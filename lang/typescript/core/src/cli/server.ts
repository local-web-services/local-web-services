/**
 * Dev server bootstrap for `ldk dev`.
 *
 * Creates a Fastify server with all registered providers and the management
 * API, starts the orchestrator, and waits for a shutdown signal.
 */

import Fastify from "fastify";
import { Orchestrator } from "../runtime/orchestrator.js";
import { SqsProvider } from "../providers/sqs/provider.js";
import { sqsRoutesPlugin } from "../providers/sqs/routes.js";
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
  const providers = new Map([["sqs", sqsProvider as never]]);
  const startupOrder = ["sqs"];

  const orchestrator = new Orchestrator();
  await orchestrator.start(providers, startupOrder);

  const app = Fastify({ logger: false });
  app.register(sqsRoutesPlugin, { provider: sqsProvider, port });
  app.register(managementPlugin, { orchestrator, providers });

  await app.listen({ port, host: "127.0.0.1" });

  const handle: DevServerHandle = {
    port,
    waitForShutdown: () => orchestrator.waitForShutdown(),
    stop: async () => {
      await orchestrator.stop();
      await app.close();
    },
  };

  return handle;
}
