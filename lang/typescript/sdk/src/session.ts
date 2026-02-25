/**
 * LwsSession — main entry point for the lws TypeScript testing SDK.
 *
 * Spawns `ldk dev` in a background process and provides pre-configured
 * AWS SDK v3 clients pointing at the local services.
 */

import { ChildProcess, spawn } from "child_process";
import * as fs from "fs/promises";
import * as net from "net";
import * as os from "os";
import * as path from "path";

import type { ResourceSpec } from "./types";
import { DynamoDBHelper } from "./resources/dynamodb";
import { SQSHelper } from "./resources/sqs";
import { S3Helper } from "./resources/s3";
import { FakeBuilder } from "./builders/fake";
import { ChaosBuilder } from "./builders/chaos";
import { IamBuilder } from "./builders/iam";
import { LogCapture } from "./logs";

// Port offsets relative to the base port (matches ldk.py _create_providers)
const SERVICE_OFFSETS: Record<string, number> = {
  dynamodb: 1,
  sqs: 2,
  s3: 3,
  sns: 4,
  eventbridge: 5,
  stepfunctions: 6,
  ssm: 12,
  secretsmanager: 13,
};

// Maps service name → AWS SDK v3 endpoint URL env var.
// Note: AWS SDK v3 uses "STATES" for Step Functions and "SECRETS_MANAGER"
// (with underscore) for Secrets Manager — different from boto3's names.
const SERVICE_ENV_VARS: Record<string, string> = {
  dynamodb: "AWS_ENDPOINT_URL_DYNAMODB",
  sqs: "AWS_ENDPOINT_URL_SQS",
  s3: "AWS_ENDPOINT_URL_S3",
  sns: "AWS_ENDPOINT_URL_SNS",
  stepfunctions: "AWS_ENDPOINT_URL_STATES",
  ssm: "AWS_ENDPOINT_URL_SSM",
  secretsmanager: "AWS_ENDPOINT_URL_SECRETS_MANAGER",
};

const TEST_CREDENTIALS: Record<string, string> = {
  AWS_ACCESS_KEY_ID: "test",
  AWS_SECRET_ACCESS_KEY: "test",
  AWS_DEFAULT_REGION: "us-east-1",
};

function freePort(): Promise<number> {
  return new Promise((resolve, reject) => {
    const server = net.createServer();
    server.listen(0, "127.0.0.1", () => {
      const addr = server.address() as net.AddressInfo;
      server.close(() => resolve(addr.port));
    });
    server.on("error", reject);
  });
}

async function waitForReady(
  managementUrl: string,
  timeoutMs = 60_000,
  intervalMs = 200
): Promise<void> {
  const maxRetries = 3;
  for (let attempt = 0; attempt <= maxRetries; attempt++) {
    const deadline = Date.now() + timeoutMs;
    while (Date.now() < deadline) {
      try {
        const res = await fetch(`${managementUrl}/_ldk/status`);
        if (res.ok) return;
      } catch {
        // not ready yet
      }
      await new Promise((r) => setTimeout(r, intervalMs));
    }
    if (attempt < maxRetries) {
      console.warn(
        `[lws] ldk dev not ready after ${timeoutMs}ms, retrying in 15 s... (${attempt + 1}/${maxRetries})`
      );
      await new Promise((r) => setTimeout(r, 15_000));
    }
  }
  throw new Error(
    `ldk dev did not become ready after ${maxRetries} retries. ` +
      "Check that local-web-services is installed (pip install local-web-services)."
  );
}

export class LwsSession {
  private readonly _basePort: number;
  private readonly _projectDir: string;
  private readonly _spec: ResourceSpec;
  private _process: ChildProcess | null = null;
  private _tempDir: string | null = null;
  private _savedEnv: Record<string, string | undefined> = {};

  private constructor(
    basePort: number,
    projectDir: string,
    spec: ResourceSpec
  ) {
    this._basePort = basePort;
    this._projectDir = projectDir;
    this._spec = spec;
  }

  // ── Constructors ────────────────────────────────────────────────────────────

  /**
   * Create a session from an explicit resource specification.
   *
   * Generates a temporary Terraform project from the spec and starts `ldk dev`.
   */
  static async create(spec: ResourceSpec = {}): Promise<LwsSession> {
    const basePort = await freePort();
    const tempDir = await fs.mkdtemp(path.join(os.tmpdir(), "lws-testing-"));
    await generateTerraformConfig(tempDir);

    const session = new LwsSession(basePort, tempDir, spec);
    session._tempDir = tempDir;
    await session._start();
    await session._preCreateResources(spec);
    return session;
  }

  /**
   * Create a session by discovering resources from a CDK project.
   *
   * Reads the synthesised cloud assembly in `{projectDir}/cdk.out/`.
   * Run `npx cdk synth` before starting the session if `cdk.out/` is
   * not already present.
   */
  static async fromCdk(projectDir: string = "."): Promise<LwsSession> {
    const basePort = await freePort();
    const session = new LwsSession(basePort, projectDir, {});
    await session._start("cdk");
    return session;
  }

  /**
   * Create a session by discovering resources from a Terraform / HCL project.
   *
   * Reads `.tf` files in `projectDir`, discovers AWS resources, starts ldk,
   * and pre-creates the discovered resources so they are immediately available.
   */
  static async fromHcl(projectDir: string = "."): Promise<LwsSession> {
    const { discoverHcl } = await import("./discovery/hcl");

    const resolvedDir = path.resolve(projectDir);
    const spec = discoverHcl(resolvedDir);

    const basePort = await freePort();
    const tempDir = await fs.mkdtemp(path.join(os.tmpdir(), "lws-testing-"));
    await generateTerraformConfig(tempDir);

    const session = new LwsSession(basePort, tempDir, spec);
    session._tempDir = tempDir;
    await session._start();
    await session._preCreateResources(spec);

    return session;
  }

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  private async _start(mode?: string): Promise<void> {
    const args = ["dev", "--project-dir", this._projectDir, "--port", String(this._basePort)];
    if (mode) {
      args.push("--mode", mode);
    }

    this._process = spawn("ldk", args, {
      stdio: ["ignore", "pipe", "pipe"],
      detached: false,
    });

    this._process.on("error", (err) => {
      throw new Error(
        `Failed to start ldk: ${err.message}. ` +
          "Ensure local-web-services is installed: pip install local-web-services"
      );
    });

    const managementUrl = `http://127.0.0.1:${this._basePort}`;
    await waitForReady(managementUrl);
    this._patchEnv();
  }

  /** Stop the ldk dev process and clean up any temporary files. */
  async close(): Promise<void> {
    this._restoreEnv();

    if (this._process) {
      this._process.kill("SIGTERM");
      await new Promise<void>((resolve) => {
        this._process!.once("exit", () => resolve());
        setTimeout(resolve, 5000); // force close after 5s
      });
      this._process = null;
    }
    if (this._tempDir) {
      await fs.rm(this._tempDir, { recursive: true, force: true });
      this._tempDir = null;
    }
  }

  // ── Environment patching ────────────────────────────────────────────────────

  /**
   * Set AWS SDK v3 endpoint env vars so any client created in this process
   * hits the local LWS services — no production-code changes required.
   */
  private _patchEnv(): void {
    for (const [service, envVar] of Object.entries(SERVICE_ENV_VARS)) {
      const offset = SERVICE_OFFSETS[service];
      if (offset === undefined) continue;
      this._savedEnv[envVar] = process.env[envVar];
      process.env[envVar] = `http://127.0.0.1:${this._basePort + offset}`;
    }
    for (const [key, val] of Object.entries(TEST_CREDENTIALS)) {
      this._savedEnv[key] = process.env[key];
      process.env[key] = val;
    }
  }

  /** Restore all env vars overridden by {@link _patchEnv}. */
  private _restoreEnv(): void {
    for (const [key, savedVal] of Object.entries(this._savedEnv)) {
      if (savedVal === undefined) {
        delete process.env[key];
      } else {
        process.env[key] = savedVal;
      }
    }
    this._savedEnv = {};
  }

  /**
   * Return the local SQS URL for `queueName`.
   *
   * Use this to set the queue URL env var that production code reads:
   * ```ts
   * process.env.ORDER_QUEUE_URL = session.queueUrl("OrderQueue");
   * ```
   */
  queueUrl(queueName: string): string {
    return `http://127.0.0.1:${this._basePort + SERVICE_OFFSETS.sqs}/000000000000/${queueName}`;
  }

  // ── AWS client factory ──────────────────────────────────────────────────────

  /**
   * Return a pre-configured AWS SDK v3 client pointing at the local service.
   *
   * @param service  AWS service name, e.g. `"dynamodb"`, `"s3"`, `"sqs"`.
   */
  client<T>(service: string): T {
    const offset = SERVICE_OFFSETS[service.toLowerCase()];
    if (offset === undefined) {
      throw new Error(
        `Service "${service}" is not supported. Available: ${Object.keys(SERVICE_OFFSETS).join(", ")}`
      );
    }
    const port = this._basePort + offset;
    const endpointUrl = `http://127.0.0.1:${port}`;
    const credentials = {
      accessKeyId: "test",
      secretAccessKey: "test",
    };
    const region = "us-east-1";

    switch (service.toLowerCase()) {
      case "dynamodb": {
        const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
        return new DynamoDBClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "s3": {
        const { S3Client } = require("@aws-sdk/client-s3");
        return new S3Client({
          endpoint: endpointUrl,
          credentials,
          region,
          forcePathStyle: true,
        }) as T;
      }
      case "sqs": {
        const { SQSClient } = require("@aws-sdk/client-sqs");
        return new SQSClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "sns": {
        const { SNSClient } = require("@aws-sdk/client-sns");
        return new SNSClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "ssm": {
        const { SSMClient } = require("@aws-sdk/client-ssm");
        return new SSMClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "secretsmanager": {
        const { SecretsManagerClient } = require("@aws-sdk/client-secrets-manager");
        return new SecretsManagerClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "stepfunctions": {
        const { SFNClient } = require("@aws-sdk/client-sfn");
        return new SFNClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      default: {
        throw new Error(`No SDK client implementation for service "${service}"`);
      }
    }
  }

  // ── State management ────────────────────────────────────────────────────────

  /** Clear all in-memory state. Call between tests for isolation. */
  async reset(): Promise<void> {
    await this._resetDynamoDB();
    await this._resetSqs();
    await this._resetS3();
  }

  private async _resetDynamoDB(): Promise<void> {
    if (!("dynamodb" in SERVICE_OFFSETS)) return;
    const { DynamoDBClient, ScanCommand, DeleteItemCommand } = require("@aws-sdk/client-dynamodb");
    const dynamo = this.client<typeof DynamoDBClient>("dynamodb");
    const tables = this._spec.tables ?? [];
    for (const tableSpec of tables) {
      const name = typeof tableSpec === "string" ? tableSpec : tableSpec.name;
      const partitionKey =
        typeof tableSpec === "string" ? "id" : tableSpec.partitionKey;
      const sortKey = typeof tableSpec === "string" ? undefined : tableSpec.sortKey;
      const keyNames = [partitionKey, ...(sortKey ? [sortKey] : [])];
      const projection = keyNames.map((k, i) => `#k${i}`).join(", ");
      const exprNames = Object.fromEntries(keyNames.map((k, i) => [`#k${i}`, k]));

      let lastKey: Record<string, unknown> | undefined;
      do {
        const scanInput: Record<string, unknown> = {
          TableName: name,
          ProjectionExpression: projection,
          ExpressionAttributeNames: exprNames,
        };
        if (lastKey) scanInput.ExclusiveStartKey = lastKey;

        const result = await dynamo.send(new ScanCommand(scanInput));
        for (const item of result.Items ?? []) {
          const key = Object.fromEntries(keyNames.map((k) => [k, item[k]]));
          await dynamo.send(new DeleteItemCommand({ TableName: name, Key: key }));
        }
        lastKey = result.LastEvaluatedKey;
      } while (lastKey);
    }
  }

  private async _resetSqs(): Promise<void> {
    const { SQSClient, PurgeQueueCommand } = require("@aws-sdk/client-sqs");
    const sqs = this.client<typeof SQSClient>("sqs");
    const port = this._basePort + SERVICE_OFFSETS.sqs;
    for (const queueSpec of this._spec.queues ?? []) {
      const name = typeof queueSpec === "string" ? queueSpec : queueSpec.name;
      const queueUrl = `http://127.0.0.1:${port}/000000000000/${name}`;
      try {
        await sqs.send(new PurgeQueueCommand({ QueueUrl: queueUrl }));
      } catch {
        // ignore if queue doesn't exist or other errors
      }
    }
  }

  private async _resetS3(): Promise<void> {
    const {
      S3Client,
      ListObjectsV2Command,
      DeleteObjectCommand,
    } = require("@aws-sdk/client-s3");
    const s3 = this.client<typeof S3Client>("s3");
    for (const bucketSpec of this._spec.buckets ?? []) {
      const name =
        typeof bucketSpec === "string" ? bucketSpec : (bucketSpec as { name: string }).name;
      let token: string | undefined;
      do {
        const listInput: Record<string, unknown> = { Bucket: name };
        if (token) listInput.ContinuationToken = token;
        const result = await s3.send(new ListObjectsV2Command(listInput));
        for (const obj of result.Contents ?? []) {
          await s3.send(
            new DeleteObjectCommand({ Bucket: name, Key: obj.Key! })
          );
        }
        token = result.NextContinuationToken;
      } while (token);
    }
  }

  // ── Resource helpers ────────────────────────────────────────────────────────

  dynamodb(tableName: string): DynamoDBHelper {
    return new DynamoDBHelper(tableName, this.client("dynamodb"));
  }

  sqs(queueName: string): SQSHelper {
    const port = this._basePort + SERVICE_OFFSETS.sqs;
    return new SQSHelper(queueName, this.client("sqs"), port);
  }

  s3(bucketName: string): S3Helper {
    return new S3Helper(bucketName, this.client("s3"));
  }

  // ── Fake / chaos / IAM builders ─────────────────────────────────────────────

  fake(service: string): FakeBuilder {
    return new FakeBuilder(service, this._basePort);
  }

  chaos(service: string): ChaosBuilder {
    return new ChaosBuilder(service, this._basePort);
  }

  get iam(): IamBuilder {
    return new IamBuilder(this._basePort);
  }

  // ── Resource pre-creation ───────────────────────────────────────────────────

  private async _preCreateResources(spec: ResourceSpec): Promise<void> {
    const credentials = { accessKeyId: "test", secretAccessKey: "test" };
    const region = "us-east-1";

    if ((spec.tables ?? []).length > 0) {
      const {
        DynamoDBClient,
        CreateTableCommand,
      } = require("@aws-sdk/client-dynamodb");
      const port = this._basePort + SERVICE_OFFSETS.dynamodb;
      const ddb = new DynamoDBClient({
        endpoint: `http://127.0.0.1:${port}`,
        credentials,
        region,
      });
      for (const tableSpec of spec.tables ?? []) {
        const name = typeof tableSpec === "string" ? tableSpec : tableSpec.name;
        const pk = typeof tableSpec === "string" ? "id" : tableSpec.partitionKey;
        const sk = typeof tableSpec === "string" ? undefined : tableSpec.sortKey;
        const keySchema: Array<{ AttributeName: string; KeyType: string }> = [
          { AttributeName: pk, KeyType: "HASH" },
        ];
        const attrDefs: Array<{ AttributeName: string; AttributeType: string }> = [
          { AttributeName: pk, AttributeType: "S" },
        ];
        if (sk) {
          keySchema.push({ AttributeName: sk, KeyType: "RANGE" });
          attrDefs.push({ AttributeName: sk, AttributeType: "S" });
        }
        await ddb.send(
          new CreateTableCommand({
            TableName: name,
            KeySchema: keySchema,
            AttributeDefinitions: attrDefs,
            BillingMode: "PAY_PER_REQUEST",
          })
        );
      }
    }

    if ((spec.queues ?? []).length > 0) {
      const { SQSClient, CreateQueueCommand } = require("@aws-sdk/client-sqs");
      const port = this._basePort + SERVICE_OFFSETS.sqs;
      const sqsClient = new SQSClient({
        endpoint: `http://127.0.0.1:${port}`,
        credentials,
        region,
      });
      for (const queueSpec of spec.queues ?? []) {
        const name = typeof queueSpec === "string" ? queueSpec : queueSpec.name;
        const isFifo = typeof queueSpec !== "string" && queueSpec.isFifo;
        const attrs: Record<string, string> = {};
        if (isFifo) attrs["FifoQueue"] = "true";
        await sqsClient.send(
          new CreateQueueCommand({ QueueName: name, Attributes: Object.keys(attrs).length ? attrs : undefined })
        );
      }
    }

    if ((spec.buckets ?? []).length > 0) {
      const { S3Client, CreateBucketCommand } = require("@aws-sdk/client-s3");
      const port = this._basePort + SERVICE_OFFSETS.s3;
      const s3Client = new S3Client({
        endpoint: `http://127.0.0.1:${port}`,
        credentials,
        region,
        forcePathStyle: true,
      });
      for (const bucketSpec of spec.buckets ?? []) {
        const name =
          typeof bucketSpec === "string" ? bucketSpec : (bucketSpec as { name: string }).name;
        await s3Client.send(new CreateBucketCommand({ Bucket: name }));
      }
    }

    if ((spec.topics ?? []).length > 0) {
      const { SNSClient, CreateTopicCommand } = require("@aws-sdk/client-sns");
      const port = this._basePort + SERVICE_OFFSETS.sns;
      const snsClient = new SNSClient({
        endpoint: `http://127.0.0.1:${port}`,
        credentials,
        region,
      });
      for (const topicSpec of spec.topics ?? []) {
        const name = typeof topicSpec === "string" ? topicSpec : topicSpec.name;
        await snsClient.send(new CreateTopicCommand({ Name: name }));
      }
    }

    if ((spec.stateMachines ?? []).length > 0) {
      const sfnPort = this._basePort + SERVICE_OFFSETS["stepfunctions"];
      for (const sm of spec.stateMachines ?? []) {
        const definition =
          typeof sm.definition === "object"
            ? JSON.stringify(sm.definition)
            : (sm.definition ?? "{}");
        await fetch(`http://127.0.0.1:${sfnPort}`, {
          method: "POST",
          headers: {
            "Content-Type": "application/x-amz-json-1.0",
            "X-Amz-Target": "AWSStepFunctions.CreateStateMachine",
          },
          body: JSON.stringify({
            name: sm.name,
            definition,
            roleArn:
              sm.roleArn ?? "arn:aws:iam::000000000000:role/StepFunctionsRole",
            type: "STANDARD",
          }),
        });
      }
    }
  }

  // ── Log capture ─────────────────────────────────────────────────────────────

  async captureLogsStart(): Promise<LogCapture> {
    const capture = new LogCapture(this._basePort);
    await capture.start();
    return capture;
  }

  // ── Port info ───────────────────────────────────────────────────────────────

  portFor(service: string): number {
    const offset = SERVICE_OFFSETS[service.toLowerCase()];
    if (offset === undefined) {
      throw new Error(`Unknown service: ${service}`);
    }
    return this._basePort + offset;
  }
}

// ── Terraform config generator ──────────────────────────────────────────────

async function generateTerraformConfig(dir: string): Promise<void> {
  // ldk requires at least one .tf file to detect the project as Terraform mode.
  // Resources are created explicitly via _preCreateResources after ldk starts.
  await fs.writeFile(
    path.join(dir, "main.tf"),
    "# local-web-services testing session\n",
    "utf8"
  );
}
