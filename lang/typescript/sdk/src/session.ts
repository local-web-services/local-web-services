/**
 * LwsSession — main entry point for the TypeScript testing SDK.
 *
 * Starts all required LWS service providers in-process, patches
 * process.env so any AWS SDK client created with default config hits
 * the local service, and provides helpers for seeding state,
 * configuring fakes/chaos, and asserting side effects.
 *
 * Mirrors `lws_testing/session.py`.
 */

import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import type { IProvider, IOrchestratorStatus } from "local-web-services-typescript-core";
import {
  SqsProvider,
  sqsRoutesPlugin,
  managementPlugin,
  findFreePort,
  buildSdkEnv,
  defaultChaosConfig,
} from "local-web-services-typescript-core";
import { type ResourceSpec, SqsQueue } from "./specs.js";
import { ChaosBuilder } from "./builders/chaos.js";
import { FakeBuilder } from "./builders/fake.js";
import { CapacityBuilder } from "./builders/capacity.js";
import { IamBuilder } from "./builders/iam.js";
import { LifecycleBuilder } from "./builders/lifecycle.js";
import { discoverFromCdk } from "./discovery/cdk.js";
import { discoverFromHcl } from "./discovery/hcl.js";

const TEST_ACCOUNT = "000000000000";

export class LwsSession {
  private readonly _resources: ResourceSpec[];

  private _sqsPort: number = 0;
  private _mgmtPort: number = 0;
  private _sqsFastify: FastifyInstance | null = null;
  private _mgmtFastify: FastifyInstance | null = null;
  private _sqsProvider: SqsProvider | null = null;
  private _savedEnv: Record<string, string | undefined> = {};

  constructor(...resources: ResourceSpec[]) {
    this._resources = resources;
  }

  // ── Constructors ────────────────────────────────────────────────────────────

  static fromCdk(projectDir: string = "."): LwsSession {
    const resources = discoverFromCdk(projectDir);
    return new LwsSession(...resources);
  }

  static fromHcl(projectDir: string = "."): LwsSession {
    const resources = discoverFromHcl(projectDir);
    return new LwsSession(...resources);
  }

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  async start(): Promise<void> {
    // Allocate ports (release reservations immediately — Fastify binds in the same tick)
    const { port: sqsPort, release: releaseSqs } = await findFreePort();
    const { port: mgmtPort, release: releaseMgmt } = await findFreePort();
    releaseSqs();
    releaseMgmt();
    this._sqsPort = sqsPort;
    this._mgmtPort = mgmtPort;

    // Build SQS provider from spec
    const sqsQueueConfigs = this._resources
      .filter((r): r is SqsQueue => r instanceof SqsQueue)
      .map((q) => ({
        queueName: q.name,
        visibilityTimeout: q.visibilityTimeout,
        isFifo: q.isFifo,
      }));

    this._sqsProvider = new SqsProvider(sqsQueueConfigs);
    await this._sqsProvider.start();

    // Start per-service Fastify server
    this._sqsFastify = Fastify({ logger: false });
    const sqsChaos = defaultChaosConfig();
    await this._sqsFastify.register(sqsRoutesPlugin, {
      provider: this._sqsProvider,
      port: sqsPort,
      chaos: sqsChaos,
    });
    await this._sqsFastify.listen({ port: sqsPort, host: "127.0.0.1" });

    // Start management API
    const providersMap = new Map<string, IProvider>([["sqs", this._sqsProvider]]);
    const chaosConfigs = new Map([["sqs", sqsChaos]]);
    const orch: IOrchestratorStatus = {
      running: true,
      providers: providersMap,
      requestShutdown: () => {},
    };

    this._mgmtFastify = Fastify({ logger: false });
    await this._mgmtFastify.register(managementPlugin, {
      orchestrator: orch,
      providers: providersMap,
      chaosConfigs,
    });
    await this._mgmtFastify.listen({ port: mgmtPort, host: "127.0.0.1" });

    // Patch process.env
    this._patchEnv({ sqs: `http://127.0.0.1:${sqsPort}` });
  }

  async stop(): Promise<void> {
    this._restoreEnv();
    await this._mgmtFastify?.close();
    await this._sqsFastify?.close();
    await this._sqsProvider?.stop();
    this._mgmtFastify = null;
    this._sqsFastify = null;
    this._sqsProvider = null;
  }

  async [Symbol.asyncDispose](): Promise<void> {
    await this.stop();
  }

  // ── Management helpers ──────────────────────────────────────────────────────

  async reset(): Promise<void> {
    const url = `http://127.0.0.1:${this._mgmtPort}/_ldk/reset`;
    const resp = await fetch(url, { method: "POST" });
    if (!resp.ok) {
      throw new Error(`session.reset() failed: ${resp.status}`);
    }
  }

  get managementUrl(): string {
    return `http://127.0.0.1:${this._mgmtPort}`;
  }

  // ── Service helpers ─────────────────────────────────────────────────────────

  endpointUrl(service: string): string {
    if (service === "sqs") return `http://127.0.0.1:${this._sqsPort}`;
    throw new Error(
      `Service '${service}' is not available in this session. Currently available: sqs`,
    );
  }

  queueUrl(queueName: string): string {
    return `http://127.0.0.1:${this._sqsPort}/${TEST_ACCOUNT}/${queueName}`;
  }

  clientConfig(service: string): {
    endpoint: string;
    credentials: { accessKeyId: string; secretAccessKey: string };
    region: string;
  } {
    return {
      endpoint: this.endpointUrl(service),
      credentials: { accessKeyId: "test", secretAccessKey: "test" },
      region: "us-east-1",
    };
  }

  // ── Builders ────────────────────────────────────────────────────────────────

  chaos(service: string): ChaosBuilder {
    return new ChaosBuilder(service, this._mgmtPort);
  }

  fake(service: string): FakeBuilder {
    return new FakeBuilder(service, this._mgmtPort);
  }

  capacity(service: string): CapacityBuilder {
    return new CapacityBuilder(service, this.managementUrl);
  }

  iam(): IamBuilder {
    return new IamBuilder(this.managementUrl);
  }

  lifecycle(service: string): LifecycleBuilder {
    return new LifecycleBuilder(service, this.managementUrl);
  }

  // ── Internal ────────────────────────────────────────────────────────────────

  private _patchEnv(endpoints: Record<string, string>): void {
    const envVars = buildSdkEnv(endpoints);
    for (const [key, value] of Object.entries(envVars)) {
      this._savedEnv[key] = process.env[key];
      process.env[key] = value;
    }
  }

  private _restoreEnv(): void {
    for (const [key, savedValue] of Object.entries(this._savedEnv)) {
      if (savedValue === undefined) {
        delete process.env[key];
      } else {
        process.env[key] = savedValue;
      }
    }
    this._savedEnv = {};
  }
}
