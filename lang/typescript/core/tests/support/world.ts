/** Cucumber World — session-scoped server, per-scenario reset. */

import {
  setWorldConstructor,
  BeforeAll,
  AfterAll,
  Before,
  World,
  IWorldOptions,
} from "@cucumber/cucumber";
import { startServer } from "../../src/index";
import type { LwsServer } from "../../src/server";
import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { SQSClient } from "@aws-sdk/client-sqs";
import { S3Client } from "@aws-sdk/client-s3";
import { SNSClient } from "@aws-sdk/client-sns";
import { EventBridgeClient } from "@aws-sdk/client-eventbridge";
import { SFNClient } from "@aws-sdk/client-sfn";
import { SSMClient } from "@aws-sdk/client-ssm";
import { SecretsManagerClient } from "@aws-sdk/client-secrets-manager";
import { CognitoIdentityProviderClient } from "@aws-sdk/client-cognito-identity-provider";
import * as cli from "../../src/cli";

const BASE_PORT = 19300;

let sharedServer: LwsServer | null = null;
let managementPort: number = BASE_PORT;

BeforeAll({ timeout: 30000 }, async () => {
  sharedServer = await startServer({ basePort: BASE_PORT });
  managementPort = BASE_PORT;
});

AfterAll(async () => {
  if (sharedServer) {
    await sharedServer.close();
    sharedServer = null;
  }
});

Before(async function (this: LwsWorld) {
  // Reset state between scenarios
  await cli.reset(managementPort);
  this.registeredFakes.clear();
});

export interface LastResult {
  success: boolean;
  output: unknown;
  error?: unknown;
}

export interface TimedResult {
  success: boolean;
  output: unknown;
  elapsedMs: number;
}

export class LwsWorld extends World {
  lastResult: LastResult = { success: false, output: null };
  timedResult: TimedResult = { success: false, output: null, elapsedMs: 0 };

  // Storage for multi-step scenarios
  lastReceiptHandle: string | undefined;
  lastQueueUrl: string | undefined;
  lastUploadId: string | undefined;
  lastBucket: string | undefined;
  lastKey: string | undefined;
  lastETag: string | undefined;
  lastExecutionArn: string | undefined;
  lastStateMachineArn: string | undefined;
  lastSubscriptionArn: string | undefined;
  lastTopicArn: string | undefined;
  lastFile: string | undefined;

  // Track registered AWS fakes by name → service
  registeredFakes: Map<string, string> = new Map();

  constructor(options: IWorldOptions) {
    super(options);
  }

  get managementPort(): number {
    return managementPort;
  }

  get ports(): Record<string, number> {
    return sharedServer?.ports ?? {};
  }

  get dynamodbPort(): number {
    return BASE_PORT + 1;
  }
  get sqsPort(): number {
    return BASE_PORT + 2;
  }
  get s3Port(): number {
    return BASE_PORT + 3;
  }
  get snsPort(): number {
    return BASE_PORT + 4;
  }
  get eventbridgePort(): number {
    return BASE_PORT + 5;
  }
  get stepfunctionsPort(): number {
    return BASE_PORT + 6;
  }
  get cognitoPort(): number {
    return BASE_PORT + 7;
  }
  get ssmPort(): number {
    return BASE_PORT + 12;
  }
  get secretsmanagerPort(): number {
    return BASE_PORT + 13;
  }

  dynamodbClient(): DynamoDBClient {
    return new DynamoDBClient({
      endpoint: `http://127.0.0.1:${this.dynamodbPort}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
    });
  }

  sqsClient(): SQSClient {
    return new SQSClient({
      endpoint: `http://127.0.0.1:${this.sqsPort}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
    });
  }

  s3Client(): S3Client {
    return new S3Client({
      endpoint: `http://127.0.0.1:${this.s3Port}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
      forcePathStyle: true,
    });
  }

  snsClient(): SNSClient {
    return new SNSClient({
      endpoint: `http://127.0.0.1:${this.snsPort}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
    });
  }

  eventbridgeClient(): EventBridgeClient {
    return new EventBridgeClient({
      endpoint: `http://127.0.0.1:${this.eventbridgePort}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
    });
  }

  sfnClient(): SFNClient {
    return new SFNClient({
      endpoint: `http://127.0.0.1:${this.stepfunctionsPort}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
      disableHostPrefix: true,
    });
  }

  ssmClient(): SSMClient {
    return new SSMClient({
      endpoint: `http://127.0.0.1:${this.ssmPort}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
    });
  }

  secretsManagerClient(): SecretsManagerClient {
    return new SecretsManagerClient({
      endpoint: `http://127.0.0.1:${this.secretsmanagerPort}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
    });
  }

  cognitoClient(): CognitoIdentityProviderClient {
    return new CognitoIdentityProviderClient({
      endpoint: `http://127.0.0.1:${this.cognitoPort}`,
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
    });
  }

  sqsQueueUrl(queueName: string): string {
    return `http://127.0.0.1:${this.sqsPort}/000000000000/${queueName}`;
  }

  cli() {
    return cli;
  }
}

setWorldConstructor(LwsWorld);
