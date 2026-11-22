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
  const providers = new Map([
    ["sqs", sqsProvider as never],
    ["dynamodb", dynamoProvider as never],
  ]);
  const startupOrder = ["sqs", "dynamodb"];

  const orchestrator = new Orchestrator();
  await orchestrator.start(providers, startupOrder);

  // SQS + management API on the main port
  const app = Fastify({ logger: false });
  app.register(sqsRoutesPlugin, { provider: sqsProvider, port });
  app.register(managementPlugin, { orchestrator, providers });
  await app.listen({ port, host: "127.0.0.1" });

  // DynamoDB on a separate port (auto-assigned)
  const { port: dynamoPort, release: releaseDynamo } = await findFreePort();
  releaseDynamo();
  const dynamoApp = Fastify({ logger: false });
  dynamoApp.register(dynamoRoutesPlugin, { provider: dynamoProvider });
  await dynamoApp.listen({ port: dynamoPort, host: "127.0.0.1" });

  const handle: DevServerHandle = {
    port,
    waitForShutdown: () => orchestrator.waitForShutdown(),
    stop: async () => {
      await orchestrator.stop();
      await app.close();
      await dynamoApp.close();
    },
  };

  return handle;
}
