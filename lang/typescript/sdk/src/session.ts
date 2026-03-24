/**
 * LwsSession — main entry point for the lws TypeScript testing SDK.
 *
 * Starts an in-process TypeScript core and provides pre-configured
 * AWS SDK v3 clients pointing at the local services.
 */

import * as fs from "fs/promises";
import * as net from "net";
import * as os from "os";
import * as path from "path";
import type { LwsServer } from "local-web-services-typescript-core";

import type { ResourceSpec } from "./types";
import { DynamoDBHelper } from "./resources/dynamodb";
import { SQSHelper } from "./resources/sqs";
import { S3Helper } from "./resources/s3";
import { FakeBuilder } from "./builders/fake";
import { ChaosBuilder } from "./builders/chaos";
import { IamBuilder } from "./builders/iam";
import { LifecycleBuilder } from "./builders/lifecycle";
import { CapacityBuilder } from "./builders/capacity";
import { LogCapture, LogEntry } from "./logs";

// Port offsets relative to the base port (matches ldk.py _create_providers)
const SERVICE_OFFSETS: Record<string, number> = {
  dynamodb: 1,
  sqs: 2,
  s3: 3,
  sns: 4,
  eventbridge: 5,
  stepfunctions: 6,
  cognitoidp: 7,
  lambda: 8,
  apigateway: 9,
  ssm: 12,
  organizations: 50,
  secretsmanager: 13,
  rds: 10,
  docdb: 11,
  elasticache: 14,
  neptune: 15,
  memorydb: 16,
  glacier: 17,
  elasticsearch: 18,
  opensearch: 19,
  s3tables: 20,
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
  cognitoidp: "AWS_ENDPOINT_URL_COGNITO_IDP",
  lambda: "AWS_ENDPOINT_URL_LAMBDA",
  ssm: "AWS_ENDPOINT_URL_SSM",
  organizations: "AWS_ENDPOINT_URL_ORGANIZATIONS",
  secretsmanager: "AWS_ENDPOINT_URL_SECRETS_MANAGER",
  rds: "AWS_ENDPOINT_URL_RDS",
  docdb: "AWS_ENDPOINT_URL_DOCDB",
  neptune: "AWS_ENDPOINT_URL_NEPTUNE",
  elasticache: "AWS_ENDPOINT_URL_ELASTICACHE",
  memorydb: "AWS_ENDPOINT_URL_MEMORY_DB",
  glacier: "AWS_ENDPOINT_URL_GLACIER",
  elasticsearch: "AWS_ENDPOINT_URL_ELASTICSEARCH",
  opensearch: "AWS_ENDPOINT_URL_OPENSEARCH",
  s3tables: "AWS_ENDPOINT_URL_S3_TABLES",
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

// ── Typed resource descriptors ───────────────────────────────────────────────

/**
 * A typed resource descriptor accepted by {@link LwsSession.start} and
 * {@link useLws}.
 */
export interface Resource {
  readonly _spec: ResourceSpec;
}

function mergeSpec(target: ResourceSpec, source: ResourceSpec): void {
  if (source.tables) target.tables = [...(target.tables ?? []), ...source.tables];
  if (source.queues) target.queues = [...(target.queues ?? []), ...source.queues];
  if (source.buckets) target.buckets = [...(target.buckets ?? []), ...source.buckets];
  if (source.topics) target.topics = [...(target.topics ?? []), ...source.topics];
  if (source.stateMachines)
    target.stateMachines = [...(target.stateMachines ?? []), ...source.stateMachines];
  if (source.parameters) target.parameters = [...(target.parameters ?? []), ...source.parameters];
  if (source.secrets) target.secrets = [...(target.secrets ?? []), ...source.secrets];
}

/** Declare a DynamoDB table resource. */
export function table(name: string, options?: { hashKey?: string; sortKey?: string }): Resource {
  const spec: import("./types").TableSpec = {
    name,
    partitionKey: options?.hashKey ?? "id",
    ...(options?.sortKey ? { sortKey: options.sortKey } : {}),
  };
  return { _spec: { tables: [spec] } };
}

/** Declare an SQS queue resource. */
export function queue(
  name: string,
  options?: { isFifo?: boolean; visibilityTimeout?: number },
): Resource {
  return { _spec: { queues: [{ name, ...options }] } };
}

/** Declare an S3 bucket resource. */
export function bucket(name: string): Resource {
  return { _spec: { buckets: [name] } };
}

/** Declare an SNS topic resource. */
export function topic(name: string): Resource {
  return { _spec: { topics: [name] } };
}

/** Declare a Step Functions state machine resource. */
export function stateMachine(
  name: string,
  definition: string | object,
  roleArn?: string,
): Resource {
  return { _spec: { stateMachines: [{ name, definition, roleArn }] } };
}

/** Declare an SSM Parameter Store parameter resource. */
export function parameter(name: string): Resource {
  return { _spec: { parameters: [{ name }] } };
}

/** Declare a Secrets Manager secret resource. */
export function secret(name: string): Resource {
  return { _spec: { secrets: [{ name }] } };
}

export class LwsSession {
  private readonly _basePort: number;
  private readonly _projectDir: string;
  private readonly _spec: ResourceSpec;
  private _server: LwsServer | null = null;
  private _tempDir: string | null = null;
  private _savedEnv: Record<string, string | undefined> = {};

  private constructor(basePort: number, projectDir: string, spec: ResourceSpec) {
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

  /**
   * Create a session from typed resource descriptors (functional-options style).
   *
   * ```ts
   * const session = await LwsSession.start(
   *   table("Orders", { hashKey: "orderId" }),
   *   queue("OrderQueue"),
   * );
   * ```
   */
  static async start(...resources: Resource[]): Promise<LwsSession> {
    const merged: ResourceSpec = {};
    for (const r of resources) {
      mergeSpec(merged, r._spec);
    }
    return LwsSession.create(merged);
  }

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  private async _start(_mode?: string): Promise<void> {
    const { startServer } = await import("local-web-services-typescript-core");
    this._server = await startServer({ basePort: this._basePort });
    this._patchEnv();
  }

  /** Stop the in-process server and clean up any temporary files. */
  async close(): Promise<void> {
    this._restoreEnv();

    if (this._server) {
      await this._server.close();
      this._server = null;
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
        `Service "${service}" is not supported. Available: ${Object.keys(SERVICE_OFFSETS).join(", ")}`,
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
      case "organizations": {
        const { OrganizationsClient } = require("@aws-sdk/client-organizations");
        return new OrganizationsClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "secretsmanager": {
        const { SecretsManagerClient } = require("@aws-sdk/client-secrets-manager");
        return new SecretsManagerClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "stepfunctions": {
        const { SFNClient } = require("@aws-sdk/client-sfn");
        return new SFNClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "cognitoidp": {
        const {
          CognitoIdentityProviderClient,
        } = require("@aws-sdk/client-cognito-identity-provider");
        return new CognitoIdentityProviderClient({
          endpoint: endpointUrl,
          credentials,
          region,
        }) as T;
      }
      case "lambda": {
        const { LambdaClient } = require("@aws-sdk/client-lambda");
        return new LambdaClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "apigateway": {
        const { APIGatewayClient } = require("@aws-sdk/client-api-gateway");
        return new APIGatewayClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "rds": {
        const { RDSClient } = require("@aws-sdk/client-rds");
        return new RDSClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "docdb": {
        const { DocDBClient } = require("@aws-sdk/client-docdb");
        return new DocDBClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "neptune": {
        const { NeptuneClient } = require("@aws-sdk/client-neptune");
        return new NeptuneClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "elasticache": {
        const { ElastiCacheClient } = require("@aws-sdk/client-elasticache");
        return new ElastiCacheClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "memorydb": {
        const { MemoryDBClient } = require("@aws-sdk/client-memory-db");
        return new MemoryDBClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "glacier": {
        const { GlacierClient } = require("@aws-sdk/client-glacier");
        return new GlacierClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "elasticsearch": {
        const { ElasticsearchServiceClient } = require("@aws-sdk/client-elasticsearch");
        return new ElasticsearchServiceClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "opensearch": {
        const { OpenSearchClient } = require("@aws-sdk/client-opensearch");
        return new OpenSearchClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      case "s3tables": {
        const { S3TablesClient } = require("@aws-sdk/client-s3tables");
        return new S3TablesClient({ endpoint: endpointUrl, credentials, region }) as T;
      }
      default: {
        throw new Error(`No SDK client implementation for service "${service}"`);
      }
    }
  }

  // ── State management ────────────────────────────────────────────────────────

  /** Clear all in-memory state. Call between tests for isolation. */
  async reset(): Promise<void> {
    await fetch(`http://127.0.0.1:${this._basePort}/_ldk/reset`, { method: "POST" });
    await this._preCreateResources(this._spec);
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

  lifecycle(service: string): LifecycleBuilder {
    return new LifecycleBuilder(service, this._basePort);
  }

  capacity(service: string): CapacityBuilder {
    return new CapacityBuilder(service, this._basePort);
  }

  async recentLogs(): Promise<LogEntry[]> {
    const response = await fetch(`http://127.0.0.1:${this._basePort}/_ldk/logs/recent`);
    if (!response.ok) {
      return [];
    }
    return response.json() as Promise<LogEntry[]>;
  }

  // ── Resource pre-creation ───────────────────────────────────────────────────

  private async _preCreateResources(spec: ResourceSpec): Promise<void> {
    const credentials = { accessKeyId: "test", secretAccessKey: "test" };
    const region = "us-east-1";

    if ((spec.tables ?? []).length > 0) {
      const { DynamoDBClient, CreateTableCommand } = require("@aws-sdk/client-dynamodb");
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
          }),
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
          new CreateQueueCommand({
            QueueName: name,
            Attributes: Object.keys(attrs).length ? attrs : undefined,
          }),
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
            roleArn: sm.roleArn ?? "arn:aws:iam::000000000000:role/StepFunctionsRole",
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

// ── Test framework integration ───────────────────────────────────────────────

/**
 * Set up a shared {@link LwsSession} for a Jest/Vitest test suite.
 *
 * Automatically wires `beforeAll`, `afterAll`, and `beforeEach` hooks so the
 * session is started once, reset between tests, and closed at the end. Call at
 * the top level of a test file or `describe` block:
 *
 * ```ts
 * const { session } = useLws(
 *   table("Orders", { hashKey: "orderId" }),
 *   queue("OrderQueue"),
 * );
 *
 * test("places an order", async () => {
 *   const db = session().client("dynamodb");
 *   ...
 * });
 * ```
 */
export function useLws(...resources: Resource[]): { session(): LwsSession } {
  let _session: LwsSession;
  // Use dynamic access so this file compiles outside a test environment.
  const g = globalThis as Record<string, unknown>;
  if (typeof g["beforeAll"] === "function") {
    (g["beforeAll"] as (fn: () => Promise<void>) => void)(async () => {
      _session = await LwsSession.start(...resources);
    });
  }
  if (typeof g["afterAll"] === "function") {
    (g["afterAll"] as (fn: () => Promise<void>) => void)(async () => {
      if (_session) await _session.close();
    });
  }
  if (typeof g["beforeEach"] === "function") {
    (g["beforeEach"] as (fn: () => Promise<void>) => void)(async () => {
      if (_session) await _session.reset();
    });
  }
  return { session: () => _session };
}

// ── Terraform config generator ──────────────────────────────────────────────

async function generateTerraformConfig(dir: string): Promise<void> {
  // ldk requires at least one .tf file to detect the project as Terraform mode.
  // Resources are created explicitly via _preCreateResources after ldk starts.
  await fs.writeFile(path.join(dir, "main.tf"), "# local-web-services testing session\n", "utf8");
}
