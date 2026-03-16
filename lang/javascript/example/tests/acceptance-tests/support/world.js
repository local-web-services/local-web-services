'use strict';

/**
 * Cucumber World for the JavaScript example BDD tests.
 *
 * Uses local-web-services-typescript-core (in-process) as the server backend.
 * A single shared LWS server is started once for the whole suite; each scenario
 * resets state via POST to /_ldk/reset and recreates helpers.
 */

const { setWorldConstructor, BeforeAll, AfterAll, Before, World } = require('@cucumber/cucumber');
const { startServer } = require('local-web-services-typescript-core');
const net = require('net');

const { DynamoDBHelper } = require('local-web-services-javascript-sdk/src/resources/dynamodb');
const { SQSHelper } = require('local-web-services-javascript-sdk/src/resources/sqs');
const { FakeBuilder } = require('local-web-services-javascript-sdk/src/builders/fake');
const { ChaosBuilder } = require('local-web-services-javascript-sdk/src/builders/chaos');
const { IamBuilder } = require('local-web-services-javascript-sdk/src/builders/iam');
const { LogCapture } = require('local-web-services-javascript-sdk/src/logs');

// Port offsets (match ldk.py _create_providers).
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

const SERVICE_ENV_VARS = {
  dynamodb: 'AWS_ENDPOINT_URL_DYNAMODB',
  sqs: 'AWS_ENDPOINT_URL_SQS',
  s3: 'AWS_ENDPOINT_URL_S3',
  sns: 'AWS_ENDPOINT_URL_SNS',
  stepfunctions: 'AWS_ENDPOINT_URL_STATES',
  ssm: 'AWS_ENDPOINT_URL_SSM',
  secretsmanager: 'AWS_ENDPOINT_URL_SECRETS_MANAGER',
};

const TEST_CREDENTIALS = {
  AWS_ACCESS_KEY_ID: 'test',
  AWS_SECRET_ACCESS_KEY: 'test',
  AWS_DEFAULT_REGION: 'us-east-1',
};

function freePort() {
  return new Promise((resolve, reject) => {
    const server = net.createServer();
    server.listen(0, '127.0.0.1', () => {
      const addr = server.address();
      server.close(() => resolve(addr.port));
    });
    server.on('error', reject);
  });
}

// Shared server state across all scenarios.
let sharedServer = null;
let sharedBasePort = null;
let savedEnv = {};

BeforeAll({ timeout: 30000 }, async function () {
  sharedBasePort = await freePort();
  sharedServer = await startServer({ basePort: sharedBasePort });

  // Patch environment variables so AWS SDK clients pick up the local endpoints.
  for (const [service, envVar] of Object.entries(SERVICE_ENV_VARS)) {
    const offset = SERVICE_OFFSETS[service];
    if (offset === undefined) continue;
    savedEnv[envVar] = process.env[envVar];
    process.env[envVar] = `http://127.0.0.1:${sharedBasePort + offset}`;
  }
  for (const [key, val] of Object.entries(TEST_CREDENTIALS)) {
    savedEnv[key] = process.env[key];
    process.env[key] = val;
  }
});

AfterAll({ timeout: 60000 }, async function () {
  if (sharedServer) {
    try {
      // Close with a timeout race to avoid hanging
      await Promise.race([
        sharedServer.close(),
        new Promise((resolve) => setTimeout(resolve, 10000)),
      ]);
    } catch (_) {}
    sharedServer = null;
  }
  // Restore environment variables.
  for (const [key, savedVal] of Object.entries(savedEnv)) {
    if (savedVal === undefined) {
      delete process.env[key];
    } else {
      process.env[key] = savedVal;
    }
  }
  savedEnv = {};
});

// ── World class ────────────────────────────────────────────────────────────

class ExampleWorld extends World {
  constructor(options) {
    super(options);

    this.basePort = null;
    this.server = null;

    // SFN client and state machine ARN.
    this.sfnClient = null;
    this.stateMachineArn = null;

    // Last processOrder result/error.
    this.lastOutput = null;
    this.lastError = null;

    // Multiple order results.
    this.processedOutputs = [];
    this.processedIDs = [];

    // Log capture.
    this.logCapture = null;

    // Fake execution ARN.
    this.fakeExecutionArn = null;

    // Resource helpers.
    this.ddbHelper = null;
    this.sqsHelper = null;
  }

  get _basePort() {
    return sharedBasePort;
  }

  createSFNClient() {
    const { SFNClient } = require('@aws-sdk/client-sfn');
    const port = sharedBasePort + SERVICE_OFFSETS.stepfunctions;
    return new SFNClient({
      endpoint: `http://127.0.0.1:${port}`,
      credentials: { accessKeyId: 'test', secretAccessKey: 'test' },
      region: 'us-east-1',
    });
  }

  createDynamoDBClient() {
    const { DynamoDBClient } = require('@aws-sdk/client-dynamodb');
    const port = sharedBasePort + SERVICE_OFFSETS.dynamodb;
    return new DynamoDBClient({
      endpoint: `http://127.0.0.1:${port}`,
      credentials: { accessKeyId: 'test', secretAccessKey: 'test' },
      region: 'us-east-1',
    });
  }

  createSQSClient() {
    const { SQSClient } = require('@aws-sdk/client-sqs');
    const port = sharedBasePort + SERVICE_OFFSETS.sqs;
    return new SQSClient({
      endpoint: `http://127.0.0.1:${port}`,
      credentials: { accessKeyId: 'test', secretAccessKey: 'test' },
      region: 'us-east-1',
    });
  }

  async managementFetch(path, opts = {}) {
    return fetch(`http://127.0.0.1:${sharedBasePort}${path}`, opts);
  }

  fake(service) {
    return new FakeBuilder(service, sharedBasePort);
  }

  chaos(service) {
    return new ChaosBuilder(service, sharedBasePort);
  }

  get iam() {
    return new IamBuilder(sharedBasePort);
  }

  async captureLogsStart() {
    const capture = new LogCapture(sharedBasePort);
    await capture.start();
    return capture;
  }

  sqsPort() {
    return sharedBasePort + SERVICE_OFFSETS.sqs;
  }

  queueUrl(queueName) {
    return `http://127.0.0.1:${this.sqsPort()}/000000000000/${queueName}`;
  }
}

Before({ timeout: 15000 }, async function () {
  // Reset state via management API before each scenario.
  try {
    await fetch(`http://127.0.0.1:${sharedBasePort}/_ldk/reset`, { method: 'POST' });
  } catch (_) {}

  // Reset per-scenario state.
  this.sfnClient = null;
  this.stateMachineArn = null;
  this.lastOutput = null;
  this.lastError = null;
  this.processedOutputs = [];
  this.processedIDs = [];
  this.fakeExecutionArn = null;
  this.ddbHelper = null;
  this.sqsHelper = null;

  if (this.logCapture) {
    try { await this.logCapture.stop(); } catch (_) {}
    this.logCapture = null;
  }
});

// Export helpers for step definitions.
module.exports.ExampleWorld = ExampleWorld;
module.exports.SERVICE_OFFSETS = SERVICE_OFFSETS;
module.exports.SERVICE_ENV_VARS = SERVICE_ENV_VARS;

setWorldConstructor(ExampleWorld);
