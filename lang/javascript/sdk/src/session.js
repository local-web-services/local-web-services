"use strict";

/**
 * LwsSession — main entry point for the lws JavaScript testing SDK.
 *
 * Spawns `ldk dev` in a background process and provides pre-configured
 * AWS SDK v3 clients pointing at the local services.
 */

const { spawn } = require("child_process");
const fs = require("fs/promises");
const net = require("net");
const os = require("os");
const path = require("path");

const { DynamoDBHelper } = require("./resources/dynamodb");
const { SQSHelper } = require("./resources/sqs");
const { S3Helper } = require("./resources/s3");
const { FakeBuilder } = require("./builders/fake");
const { ChaosBuilder } = require("./builders/chaos");
const { IamBuilder } = require("./builders/iam");
const { LogCapture } = require("./logs");

// Port offsets relative to the base port (matches ldk.py _create_providers)
const SERVICE_OFFSETS = {
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
const SERVICE_ENV_VARS = {
  dynamodb: "AWS_ENDPOINT_URL_DYNAMODB",
  sqs: "AWS_ENDPOINT_URL_SQS",
  s3: "AWS_ENDPOINT_URL_S3",
  sns: "AWS_ENDPOINT_URL_SNS",
  stepfunctions: "AWS_ENDPOINT_URL_STATES",
  ssm: "AWS_ENDPOINT_URL_SSM",
  secretsmanager: "AWS_ENDPOINT_URL_SECRETS_MANAGER",
};

const TEST_CREDENTIALS = {
  AWS_ACCESS_KEY_ID: "test",
  AWS_SECRET_ACCESS_KEY: "test",
  AWS_DEFAULT_REGION: "us-east-1",
};

function freePort() {
  return new Promise((resolve, reject) => {
    const server = net.createServer();
    server.listen(0, "127.0.0.1", () => {
      const addr = server.address();
      server.close(() => resolve(addr.port));
    });
    server.on("error", reject);
  });
}

async function waitForReady(managementUrl, timeoutMs = 30000, intervalMs = 200) {
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
  throw new Error(
    `ldk dev did not become ready within ${timeoutMs}ms. ` +
      "Check that local-web-services is installed (pip install local-web-services)."
  );
}

async function generateTerraformConfig(dir, spec) {
  const lines = [];

  for (const tableSpec of spec.tables ?? []) {
    const name = typeof tableSpec === "string" ? tableSpec : tableSpec.name;
    const pk = typeof tableSpec === "string" ? "id" : tableSpec.partitionKey;
    const sk = typeof tableSpec === "string" ? undefined : tableSpec.sortKey;
    const logicalId = name.toLowerCase().replace(/[^a-z0-9]/g, "_");

    lines.push(`resource "aws_dynamodb_table" "${logicalId}" {`);
    lines.push(`  name         = "${name}"`);
    lines.push(`  hash_key     = "${pk}"`);
    lines.push(`  billing_mode = "PAY_PER_REQUEST"`);
    lines.push(`  attribute { name = "${pk}" type = "S" }`);
    if (sk) {
      lines.push(`  range_key = "${sk}"`);
      lines.push(`  attribute { name = "${sk}" type = "S" }`);
    }
    lines.push(`}`);
    lines.push("");
  }

  for (const queueSpec of spec.queues ?? []) {
    const name = typeof queueSpec === "string" ? queueSpec : queueSpec.name;
    const isFifo = typeof queueSpec !== "string" && queueSpec.isFifo;
    const logicalId = name.toLowerCase().replace(/[^a-z0-9]/g, "_");
    lines.push(`resource "aws_sqs_queue" "${logicalId}" {`);
    lines.push(`  name = "${name}"`);
    if (isFifo) lines.push(`  fifo_queue = true`);
    lines.push(`}`);
    lines.push("");
  }

  for (const bucketSpec of spec.buckets ?? []) {
    const name = typeof bucketSpec === "string" ? bucketSpec : bucketSpec.name;
    const logicalId = name.toLowerCase().replace(/[^a-z0-9]/g, "_");
    lines.push(`resource "aws_s3_bucket" "${logicalId}" {`);
    lines.push(`  bucket = "${name}"`);
    lines.push(`}`);
    lines.push("");
  }

  for (const topicSpec of spec.topics ?? []) {
    const name = typeof topicSpec === "string" ? topicSpec : topicSpec.name;
    const logicalId = name.toLowerCase().replace(/[^a-z0-9]/g, "_");
    lines.push(`resource "aws_sns_topic" "${logicalId}" {`);
    lines.push(`  name = "${name}"`);
    lines.push(`}`);
    lines.push("");
  }

  await fs.writeFile(path.join(dir, "main.tf"), lines.join("\n"), "utf8");
}

class LwsSession {
  constructor(basePort, projectDir, spec) {
    this._basePort = basePort;
    this._projectDir = projectDir;
    this._spec = spec;
    this._process = null;
    this._tempDir = null;
    this._savedEnv = {};
  }

  // ── Constructors ────────────────────────────────────────────────────────────

  /**
   * Create a session from an explicit resource specification.
   *
   * Generates a temporary Terraform project from the spec and starts `ldk dev`.
   *
   * @param {object} [spec={}]
   * @returns {Promise<LwsSession>}
   */
  static async create(spec = {}) {
    const basePort = await freePort();
    const tempDir = await fs.mkdtemp(path.join(os.tmpdir(), "lws-testing-"));
    await generateTerraformConfig(tempDir, spec);

    const session = new LwsSession(basePort, tempDir, spec);
    session._tempDir = tempDir;
    await session._start();
    return session;
  }

  /**
   * Create a session by discovering resources from a CDK project.
   *
   * @param {string} [projectDir="."]
   * @returns {Promise<LwsSession>}
   */
  static async fromCdk(projectDir = ".") {
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
   *
   * @param {string} [projectDir="."]
   * @returns {Promise<LwsSession>}
   */
  static async fromHcl(projectDir = ".") {
    const { discoverHcl } = require("./discovery/hcl");

    const resolvedDir = path.resolve(projectDir);
    const spec = discoverHcl(resolvedDir);

    const basePort = await freePort();
    const tempDir = await fs.mkdtemp(path.join(os.tmpdir(), "lws-testing-"));
    await generateTerraformConfig(tempDir, spec);

    const session = new LwsSession(basePort, tempDir, spec);
    session._tempDir = tempDir;
    await session._start();

    // Pre-create state machines discovered from the HCL files.
    const sfnPort = basePort + SERVICE_OFFSETS["stepfunctions"];
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

    return session;
  }

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  async _start(mode) {
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
  async close() {
    this._restoreEnv();

    if (this._process) {
      this._process.kill("SIGTERM");
      await new Promise((resolve) => {
        this._process.once("exit", () => resolve());
        setTimeout(resolve, 5000);
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
  _patchEnv() {
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

  /** Restore all env vars overridden by _patchEnv. */
  _restoreEnv() {
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
   * Return the local SQS URL for queueName.
   *
   * @param {string} queueName
   * @returns {string}
   */
  queueUrl(queueName) {
    return `http://127.0.0.1:${this._basePort + SERVICE_OFFSETS.sqs}/000000000000/${queueName}`;
  }

  // ── AWS client factory ──────────────────────────────────────────────────────

  /**
   * Return a pre-configured AWS SDK v3 client pointing at the local service.
   *
   * @param {string} service  e.g. "dynamodb", "s3", "sqs"
   * @returns {object}
   */
  client(service) {
    const offset = SERVICE_OFFSETS[service.toLowerCase()];
    if (offset === undefined) {
      throw new Error(
        `Service "${service}" is not supported. Available: ${Object.keys(SERVICE_OFFSETS).join(", ")}`
      );
    }
    const port = this._basePort + offset;
    const endpointUrl = `http://127.0.0.1:${port}`;
    const credentials = { accessKeyId: "test", secretAccessKey: "test" };
    const region = "us-east-1";

    switch (service.toLowerCase()) {
      case "dynamodb": {
        const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
        return new DynamoDBClient({ endpoint: endpointUrl, credentials, region });
      }
      case "s3": {
        const { S3Client } = require("@aws-sdk/client-s3");
        return new S3Client({ endpoint: endpointUrl, credentials, region, forcePathStyle: true });
      }
      case "sqs": {
        const { SQSClient } = require("@aws-sdk/client-sqs");
        return new SQSClient({ endpoint: endpointUrl, credentials, region });
      }
      case "sns": {
        const { SNSClient } = require("@aws-sdk/client-sns");
        return new SNSClient({ endpoint: endpointUrl, credentials, region });
      }
      case "ssm": {
        const { SSMClient } = require("@aws-sdk/client-ssm");
        return new SSMClient({ endpoint: endpointUrl, credentials, region });
      }
      case "secretsmanager": {
        const { SecretsManagerClient } = require("@aws-sdk/client-secrets-manager");
        return new SecretsManagerClient({ endpoint: endpointUrl, credentials, region });
      }
      case "stepfunctions": {
        const { SFNClient } = require("@aws-sdk/client-sfn");
        return new SFNClient({ endpoint: endpointUrl, credentials, region });
      }
      default:
        throw new Error(`No SDK client implementation for service "${service}"`);
    }
  }

  // ── State management ────────────────────────────────────────────────────────

  /** Clear all in-memory state. Call between tests for isolation. */
  async reset() {
    await this._resetDynamoDB();
    await this._resetSqs();
    await this._resetS3();
  }

  async _resetDynamoDB() {
    const { DynamoDBClient, ScanCommand, DeleteItemCommand } = require("@aws-sdk/client-dynamodb");
    const dynamo = this.client("dynamodb");
    for (const tableSpec of this._spec.tables ?? []) {
      const name = typeof tableSpec === "string" ? tableSpec : tableSpec.name;
      const partitionKey = typeof tableSpec === "string" ? "id" : tableSpec.partitionKey;
      const sortKey = typeof tableSpec === "string" ? undefined : tableSpec.sortKey;
      const keyNames = [partitionKey, ...(sortKey ? [sortKey] : [])];
      const projection = keyNames.map((k, i) => `#k${i}`).join(", ");
      const exprNames = Object.fromEntries(keyNames.map((k, i) => [`#k${i}`, k]));

      let lastKey;
      do {
        const scanInput = {
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
    void DynamoDBClient;
  }

  async _resetSqs() {
    const { SQSClient, PurgeQueueCommand } = require("@aws-sdk/client-sqs");
    const sqs = this.client("sqs");
    const port = this._basePort + SERVICE_OFFSETS.sqs;
    for (const queueSpec of this._spec.queues ?? []) {
      const name = typeof queueSpec === "string" ? queueSpec : queueSpec.name;
      const queueUrl = `http://127.0.0.1:${port}/000000000000/${name}`;
      try {
        await sqs.send(new PurgeQueueCommand({ QueueUrl: queueUrl }));
      } catch {
        // ignore if queue doesn't exist
      }
    }
    void SQSClient;
  }

  async _resetS3() {
    const { S3Client, ListObjectsV2Command, DeleteObjectCommand } = require("@aws-sdk/client-s3");
    const s3 = this.client("s3");
    for (const bucketSpec of this._spec.buckets ?? []) {
      const name = typeof bucketSpec === "string" ? bucketSpec : bucketSpec.name;
      let token;
      do {
        const listInput = { Bucket: name };
        if (token) listInput.ContinuationToken = token;
        const result = await s3.send(new ListObjectsV2Command(listInput));
        for (const obj of result.Contents ?? []) {
          await s3.send(new DeleteObjectCommand({ Bucket: name, Key: obj.Key }));
        }
        token = result.NextContinuationToken;
      } while (token);
    }
    void S3Client;
  }

  // ── Resource helpers ────────────────────────────────────────────────────────

  dynamodb(tableName) {
    return new DynamoDBHelper(tableName, this.client("dynamodb"));
  }

  sqs(queueName) {
    const port = this._basePort + SERVICE_OFFSETS.sqs;
    return new SQSHelper(queueName, this.client("sqs"), port);
  }

  s3(bucketName) {
    return new S3Helper(bucketName, this.client("s3"));
  }

  // ── Fake / chaos / IAM builders ─────────────────────────────────────────────

  fake(service) {
    return new FakeBuilder(service, this._basePort);
  }

  chaos(service) {
    return new ChaosBuilder(service, this._basePort);
  }

  get iam() {
    return new IamBuilder(this._basePort);
  }

  // ── Log capture ─────────────────────────────────────────────────────────────

  async captureLogsStart() {
    const capture = new LogCapture(this._basePort);
    await capture.start();
    return capture;
  }

  // ── Port info ───────────────────────────────────────────────────────────────

  portFor(service) {
    const offset = SERVICE_OFFSETS[service.toLowerCase()];
    if (offset === undefined) {
      throw new Error(`Unknown service: ${service}`);
    }
    return this._basePort + offset;
  }
}

module.exports = { LwsSession };
