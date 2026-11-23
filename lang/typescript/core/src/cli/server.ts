/**
 * Dev server bootstrap for `ldk dev`.
 *
 * Creates a Fastify server with all registered providers and the management
 * API, starts the orchestrator, and waits for a shutdown signal.
 */

import Fastify from "fastify";
import { Orchestrator } from "../runtime/orchestrator.js";
import { findFreePort } from "../runtime/portAllocator.js";
import { SqsProvider } from "../providers/sqs/provider.js";
import { sqsRoutesPlugin } from "../providers/sqs/routes.js";
import { DynamoProvider } from "../providers/dynamodb/provider.js";
import { dynamoRoutesPlugin } from "../providers/dynamodb/routes.js";
import { SsmProvider } from "../providers/ssm/provider.js";
import { ssmRoutesPlugin } from "../providers/ssm/routes.js";
import { SecretsProvider } from "../providers/secrets/provider.js";
import { secretsRoutesPlugin } from "../providers/secrets/routes.js";
import { SnsProvider } from "../providers/sns/provider.js";
import { snsRoutesPlugin } from "../providers/sns/routes.js";
import { S3Provider } from "../providers/s3/provider.js";
import { s3RoutesPlugin } from "../providers/s3/routes.js";
import { EventBridgeProvider } from "../providers/eventbridge/provider.js";
import { eventBridgeRoutesPlugin } from "../providers/eventbridge/routes.js";
import { StepFunctionsProvider } from "../providers/stepfunctions/provider.js";
import { stepFunctionsRoutesPlugin } from "../providers/stepfunctions/routes.js";
import { CognitoProvider } from "../providers/cognito/provider.js";
import { cognitoRoutesPlugin } from "../providers/cognito/routes.js";
import { LambdaProvider } from "../providers/lambda/provider.js";
import { lambdaRoutesPlugin } from "../providers/lambda/routes.js";
import { managementPlugin } from "../api/management.js";

export interface DevServerOptions {
  port: number;
}

export interface DevServerHandle {
  port: number;
  waitForShutdown: () => Promise<void>;
  stop: () => Promise<void>;
}

export async function startDevServer(options: DevServerOptions): Promise<DevServerHandle> {
  const { port } = options;

  const sqsProvider = new SqsProvider([]);
  const dynamoProvider = new DynamoProvider([]);
  const ssmProvider = new SsmProvider([]);
  const secretsProvider = new SecretsProvider([]);
  const snsProvider = new SnsProvider([]);
  const s3Provider = new S3Provider([]);
  const eventBridgeProvider = new EventBridgeProvider([]);
  const stepFunctionsProvider = new StepFunctionsProvider([]);
  const cognitoProvider = new CognitoProvider([]);
  const lambdaProvider = new LambdaProvider([]);
  const providers = new Map([
    ["sqs", sqsProvider as never],
    ["dynamodb", dynamoProvider as never],
    ["ssm", ssmProvider as never],
    ["secretsmanager", secretsProvider as never],
    ["sns", snsProvider as never],
    ["s3", s3Provider as never],
    ["events", eventBridgeProvider as never],
    ["states", stepFunctionsProvider as never],
    ["cognito-idp", cognitoProvider as never],
    ["lambda", lambdaProvider as never],
  ]);
  const startupOrder = ["sqs", "dynamodb", "ssm", "secretsmanager", "sns", "s3", "events", "states", "cognito-idp", "lambda"];

  const orchestrator = new Orchestrator();
  await orchestrator.start(providers, startupOrder);

  // SQS + management API on the main port
  const app = Fastify({ logger: false });
  app.register(sqsRoutesPlugin, { provider: sqsProvider, port });
  app.register(managementPlugin, { orchestrator, providers });
  await app.listen({ port, host: "127.0.0.1" });

  // Additional providers on separate ports
  const { port: dynamoPort, release: releaseDynamo } = await findFreePort();
  releaseDynamo();
  const dynamoApp = Fastify({ logger: false });
  dynamoApp.register(dynamoRoutesPlugin, { provider: dynamoProvider });
  await dynamoApp.listen({ port: dynamoPort, host: "127.0.0.1" });

  const { port: ssmPort, release: releaseSsm } = await findFreePort();
  releaseSsm();
  const ssmApp = Fastify({ logger: false });
  ssmApp.register(ssmRoutesPlugin, { provider: ssmProvider });
  await ssmApp.listen({ port: ssmPort, host: "127.0.0.1" });

  const { port: secretsPort, release: releaseSecrets } = await findFreePort();
  releaseSecrets();
  const secretsApp = Fastify({ logger: false });
  secretsApp.register(secretsRoutesPlugin, { provider: secretsProvider });
  await secretsApp.listen({ port: secretsPort, host: "127.0.0.1" });

  const { port: snsPort, release: releaseSns } = await findFreePort();
  releaseSns();
  const snsApp = Fastify({ logger: false });
  snsApp.register(snsRoutesPlugin, { provider: snsProvider });
  await snsApp.listen({ port: snsPort, host: "127.0.0.1" });

  const { port: s3Port, release: releaseS3 } = await findFreePort();
  releaseS3();
  const s3App = Fastify({ logger: false });
  s3App.register(s3RoutesPlugin, { provider: s3Provider });
  await s3App.listen({ port: s3Port, host: "127.0.0.1" });

  const { port: ebPort, release: releaseEb } = await findFreePort();
  releaseEb();
  const ebApp = Fastify({ logger: false });
  ebApp.register(eventBridgeRoutesPlugin, { provider: eventBridgeProvider });
  await ebApp.listen({ port: ebPort, host: "127.0.0.1" });

  const { port: sfnPort, release: releaseSfn } = await findFreePort();
  releaseSfn();
  const sfnApp = Fastify({ logger: false });
  sfnApp.register(stepFunctionsRoutesPlugin, { provider: stepFunctionsProvider });
  await sfnApp.listen({ port: sfnPort, host: "127.0.0.1" });

  const { port: cognitoPort, release: releaseCognito } = await findFreePort();
  releaseCognito();
  const cognitoApp = Fastify({ logger: false });
  cognitoApp.register(cognitoRoutesPlugin, { provider: cognitoProvider });
  await cognitoApp.listen({ port: cognitoPort, host: "127.0.0.1" });

  const { port: lambdaPort, release: releaseLambda } = await findFreePort();
  releaseLambda();
  const lambdaApp = Fastify({ logger: false });
  lambdaApp.register(lambdaRoutesPlugin, { provider: lambdaProvider });
  await lambdaApp.listen({ port: lambdaPort, host: "127.0.0.1" });

  const handle: DevServerHandle = {
    port,
    waitForShutdown: () => orchestrator.waitForShutdown(),
    stop: async () => {
      await orchestrator.stop();
      await app.close();
      await dynamoApp.close();
      await ssmApp.close();
      await secretsApp.close();
      await snsApp.close();
      await s3App.close();
      await ebApp.close();
      await sfnApp.close();
      await cognitoApp.close();
      await lambdaApp.close();
    },
  };

  return handle;
}
