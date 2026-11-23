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
  DynamoProvider,
  dynamoRoutesPlugin,
  SsmProvider,
  ssmRoutesPlugin,
  SecretsProvider,
  secretsRoutesPlugin,
  SnsProvider,
  snsRoutesPlugin,
  S3Provider,
  s3RoutesPlugin,
  EventBridgeProvider,
  eventBridgeRoutesPlugin,
  StepFunctionsProvider,
  stepFunctionsRoutesPlugin,
  CognitoProvider,
  cognitoRoutesPlugin,
  LambdaProvider,
  lambdaRoutesPlugin,
  managementPlugin,
  findFreePort,
  buildSdkEnv,
  defaultChaosConfig,
} from "local-web-services-typescript-core";
import { type ResourceSpec, SqsQueue, DynamoTable, SsmParameter, Secret, SnsTopic, S3Bucket, EventBus, StateMachine, CognitoUserPool, LambdaFunction } from "./specs.js";
import { ChaosBuilder } from "./builders/chaos.js";
import { FakeBuilder } from "./builders/fake.js";
import { CapacityBuilder } from "./builders/capacity.js";
import { IamBuilder } from "./builders/iam.js";
import { LifecycleBuilder } from "./builders/lifecycle.js";
import { parseCdkAssembly, type FromCdkOptions } from "./cdk.js";
import { discoverFromHcl } from "./discovery/hcl.js";

const TEST_ACCOUNT = "000000000000";

export class LwsSession {
  private readonly _resources: ResourceSpec[];

  private _sqsPort: number = 0;
  private _dynamoPort: number = 0;
  private _ssmPort: number = 0;
  private _secretsPort: number = 0;
  private _snsPort: number = 0;
  private _s3Port: number = 0;
  private _eventbridgePort: number = 0;
  private _stepfunctionsPort: number = 0;
  private _cognitoPort: number = 0;
  private _lambdaPort: number = 0;
  private _mgmtPort: number = 0;
  private _sqsFastify: FastifyInstance | null = null;
  private _dynamoFastify: FastifyInstance | null = null;
  private _ssmFastify: FastifyInstance | null = null;
  private _secretsFastify: FastifyInstance | null = null;
  private _snsFastify: FastifyInstance | null = null;
  private _s3Fastify: FastifyInstance | null = null;
  private _eventbridgeFastify: FastifyInstance | null = null;
  private _stepfunctionsFastify: FastifyInstance | null = null;
  private _cognitoFastify: FastifyInstance | null = null;
  private _lambdaFastify: FastifyInstance | null = null;
  private _mgmtFastify: FastifyInstance | null = null;
  private _sqsProvider: SqsProvider | null = null;
  private _dynamoProvider: DynamoProvider | null = null;
  private _ssmProvider: SsmProvider | null = null;
  private _secretsProvider: SecretsProvider | null = null;
  private _snsProvider: SnsProvider | null = null;
  private _s3Provider: S3Provider | null = null;
  private _eventbridgeProvider: EventBridgeProvider | null = null;
  private _stepfunctionsProvider: StepFunctionsProvider | null = null;
  private _cognitoProvider: CognitoProvider | null = null;
  private _lambdaProvider: LambdaProvider | null = null;
  private _savedEnv: Record<string, string | undefined> = {};

  constructor(...resources: ResourceSpec[]) {
    this._resources = resources;
  }

  // ── Constructors ────────────────────────────────────────────────────────────

  static fromCdk(options?: FromCdkOptions): LwsSession {
    const resources = parseCdkAssembly(options);
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
    const { port: dynamoPort, release: releaseDynamo } = await findFreePort();
    const { port: ssmPort, release: releaseSsm } = await findFreePort();
    const { port: secretsPort, release: releaseSecrets } = await findFreePort();
    const { port: snsPort, release: releaseSns } = await findFreePort();
    const { port: s3Port, release: releaseS3 } = await findFreePort();
    const { port: eventbridgePort, release: releaseEb } = await findFreePort();
    const { port: stepfunctionsPort, release: releaseSfn } = await findFreePort();
    const { port: cognitoPort, release: releaseCognito } = await findFreePort();
    const { port: lambdaPort, release: releaseLambda } = await findFreePort();
    const { port: mgmtPort, release: releaseMgmt } = await findFreePort();
    releaseSqs(); releaseDynamo(); releaseSsm(); releaseSecrets(); releaseSns(); releaseS3();
    releaseEb(); releaseSfn(); releaseCognito(); releaseLambda(); releaseMgmt();
    this._sqsPort = sqsPort;
    this._dynamoPort = dynamoPort;
    this._ssmPort = ssmPort;
    this._secretsPort = secretsPort;
    this._snsPort = snsPort;
    this._s3Port = s3Port;
    this._eventbridgePort = eventbridgePort;
    this._stepfunctionsPort = stepfunctionsPort;
    this._cognitoPort = cognitoPort;
    this._lambdaPort = lambdaPort;
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

    // Build DynamoDB provider from spec
    const dynamoTableConfigs = this._resources
      .filter((r): r is DynamoTable => r instanceof DynamoTable)
      .map((t) => ({
        tableName: t.name,
        hashKey: t.hashKey,
        hashKeyType: t.hashKeyType,
        sortKey: t.sortKey,
        sortKeyType: t.sortKeyType,
      }));

    this._dynamoProvider = new DynamoProvider(dynamoTableConfigs);
    await this._dynamoProvider.start();

    // Build SSM provider from spec
    const ssmConfigs = this._resources
      .filter((r): r is SsmParameter => r instanceof SsmParameter)
      .map((p) => ({ name: p.name, value: p.value, type: p.type }));
    this._ssmProvider = new SsmProvider(ssmConfigs);
    await this._ssmProvider.start();

    // Build Secrets Manager provider from spec
    const secretsConfigs = this._resources
      .filter((r): r is Secret => r instanceof Secret)
      .map((s) => ({
        name: s.name,
        ...(s.secretString !== undefined && { secretString: s.secretString }),
      }));
    this._secretsProvider = new SecretsProvider(secretsConfigs);
    await this._secretsProvider.start();

    // Build SNS provider from spec
    const snsConfigs = this._resources
      .filter((r): r is SnsTopic => r instanceof SnsTopic)
      .map((t) => ({ name: t.name }));
    this._snsProvider = new SnsProvider(snsConfigs);
    await this._snsProvider.start();

    // Build S3 provider from spec
    const s3Configs = this._resources
      .filter((r): r is S3Bucket => r instanceof S3Bucket)
      .map((b) => ({ name: b.name }));
    this._s3Provider = new S3Provider(s3Configs);
    await this._s3Provider.start();

    // Build EventBridge provider from spec
    const ebConfigs = this._resources
      .filter((r): r is EventBus => r instanceof EventBus)
      .map((b) => ({ name: b.name }));
    this._eventbridgeProvider = new EventBridgeProvider(ebConfigs);
    await this._eventbridgeProvider.start();

    // Build Step Functions provider from spec
    const sfnConfigs = this._resources
      .filter((r): r is StateMachine => r instanceof StateMachine)
      .map((m) => ({ name: m.name, definition: m.definition, roleArn: m.roleArn }));
    this._stepfunctionsProvider = new StepFunctionsProvider(sfnConfigs);
    await this._stepfunctionsProvider.start();

    // Build Cognito IDP provider from spec
    const cognitoConfigs = this._resources
      .filter((r): r is CognitoUserPool => r instanceof CognitoUserPool)
      .map((p) => ({ poolName: p.name, autoConfirmUsers: p.autoConfirmUsers }));
    this._cognitoProvider = new CognitoProvider(cognitoConfigs);
    await this._cognitoProvider.start();

    // Build Lambda provider from spec
    const lambdaConfigs = this._resources
      .filter((r): r is LambdaFunction => r instanceof LambdaFunction)
      .map((f) => ({
        functionName: f.name,
        handler: f.handler,
        runtime: f.runtime,
        ...(f.codeDir !== undefined && { codeDir: f.codeDir }),
        environment: f.environment,
        description: f.description,
      }));
    this._lambdaProvider = new LambdaProvider(lambdaConfigs);
    await this._lambdaProvider.start();

    // Start per-service Fastify server (SQS)
    this._sqsFastify = Fastify({ logger: false });
    const sqsChaos = defaultChaosConfig();
    await this._sqsFastify.register(sqsRoutesPlugin, {
      provider: this._sqsProvider,
      port: sqsPort,
      chaos: sqsChaos,
    });
    await this._sqsFastify.listen({ port: sqsPort, host: "127.0.0.1" });

    // Start per-service Fastify server (DynamoDB)
    this._dynamoFastify = Fastify({ logger: false });
    await this._dynamoFastify.register(dynamoRoutesPlugin, { provider: this._dynamoProvider });
    await this._dynamoFastify.listen({ port: dynamoPort, host: "127.0.0.1" });

    // Start per-service Fastify server (SSM)
    this._ssmFastify = Fastify({ logger: false });
    await this._ssmFastify.register(ssmRoutesPlugin, { provider: this._ssmProvider });
    await this._ssmFastify.listen({ port: ssmPort, host: "127.0.0.1" });

    // Start per-service Fastify server (Secrets Manager)
    this._secretsFastify = Fastify({ logger: false });
    await this._secretsFastify.register(secretsRoutesPlugin, { provider: this._secretsProvider });
    await this._secretsFastify.listen({ port: secretsPort, host: "127.0.0.1" });

    // Start per-service Fastify server (SNS)
    this._snsFastify = Fastify({ logger: false });
    await this._snsFastify.register(snsRoutesPlugin, { provider: this._snsProvider });
    await this._snsFastify.listen({ port: snsPort, host: "127.0.0.1" });

    // Start per-service Fastify server (S3)
    this._s3Fastify = Fastify({ logger: false, ignoreTrailingSlash: true });
    await this._s3Fastify.register(s3RoutesPlugin, { provider: this._s3Provider });
    await this._s3Fastify.listen({ port: s3Port, host: "127.0.0.1" });

    // Start per-service Fastify server (EventBridge)
    this._eventbridgeFastify = Fastify({ logger: false });
    await this._eventbridgeFastify.register(eventBridgeRoutesPlugin, { provider: this._eventbridgeProvider });
    await this._eventbridgeFastify.listen({ port: eventbridgePort, host: "127.0.0.1" });

    // Start per-service Fastify server (Step Functions)
    this._stepfunctionsFastify = Fastify({ logger: false });
    await this._stepfunctionsFastify.register(stepFunctionsRoutesPlugin, { provider: this._stepfunctionsProvider });
    await this._stepfunctionsFastify.listen({ port: stepfunctionsPort, host: "127.0.0.1" });

    // Start per-service Fastify server (Cognito IDP)
    this._cognitoFastify = Fastify({ logger: false });
    await this._cognitoFastify.register(cognitoRoutesPlugin, { provider: this._cognitoProvider });
    await this._cognitoFastify.listen({ port: cognitoPort, host: "127.0.0.1" });

    // Start per-service Fastify server (Lambda)
    this._lambdaFastify = Fastify({ logger: false });
    await this._lambdaFastify.register(lambdaRoutesPlugin, { provider: this._lambdaProvider });
    await this._lambdaFastify.listen({ port: lambdaPort, host: "127.0.0.1" });

    // Start management API
    const providersMap = new Map<string, IProvider>([
      ["sqs", this._sqsProvider],
      ["dynamodb", this._dynamoProvider],
      ["ssm", this._ssmProvider],
      ["secretsmanager", this._secretsProvider],
      ["sns", this._snsProvider],
      ["s3", this._s3Provider],
      ["events", this._eventbridgeProvider],
      ["states", this._stepfunctionsProvider],
      ["cognito-idp", this._cognitoProvider],
      ["lambda", this._lambdaProvider],
    ]);
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
    this._patchEnv({
      sqs: `http://127.0.0.1:${sqsPort}`,
      dynamodb: `http://127.0.0.1:${dynamoPort}`,
      ssm: `http://127.0.0.1:${ssmPort}`,
      secretsmanager: `http://127.0.0.1:${secretsPort}`,
      sns: `http://127.0.0.1:${snsPort}`,
      s3: `http://127.0.0.1:${s3Port}`,
      events: `http://127.0.0.1:${eventbridgePort}`,
      states: `http://127.0.0.1:${stepfunctionsPort}`,
      "cognito-idp": `http://127.0.0.1:${cognitoPort}`,
      lambda: `http://127.0.0.1:${lambdaPort}`,
    });
  }

  async stop(): Promise<void> {
    this._restoreEnv();
    await this._mgmtFastify?.close();
    await this._sqsFastify?.close();
    await this._dynamoFastify?.close();
    await this._ssmFastify?.close();
    await this._secretsFastify?.close();
    await this._snsFastify?.close();
    await this._s3Fastify?.close();
    await this._eventbridgeFastify?.close();
    await this._stepfunctionsFastify?.close();
    await this._cognitoFastify?.close();
    await this._lambdaFastify?.close();
    await this._sqsProvider?.stop();
    await this._dynamoProvider?.stop();
    await this._ssmProvider?.stop();
    await this._secretsProvider?.stop();
    await this._snsProvider?.stop();
    await this._s3Provider?.stop();
    await this._eventbridgeProvider?.stop();
    await this._stepfunctionsProvider?.stop();
    await this._cognitoProvider?.stop();
    await this._lambdaProvider?.stop();
    this._mgmtFastify = null;
    this._sqsFastify = null;
    this._dynamoFastify = null;
    this._ssmFastify = null;
    this._secretsFastify = null;
    this._snsFastify = null;
    this._s3Fastify = null;
    this._eventbridgeFastify = null;
    this._stepfunctionsFastify = null;
    this._cognitoFastify = null;
    this._lambdaFastify = null;
    this._sqsProvider = null;
    this._dynamoProvider = null;
    this._ssmProvider = null;
    this._secretsProvider = null;
    this._snsProvider = null;
    this._s3Provider = null;
    this._eventbridgeProvider = null;
    this._stepfunctionsProvider = null;
    this._cognitoProvider = null;
    this._lambdaProvider = null;
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
    if (service === "dynamodb") return `http://127.0.0.1:${this._dynamoPort}`;
    if (service === "ssm") return `http://127.0.0.1:${this._ssmPort}`;
    if (service === "secretsmanager") return `http://127.0.0.1:${this._secretsPort}`;
    if (service === "sns") return `http://127.0.0.1:${this._snsPort}`;
    if (service === "s3") return `http://127.0.0.1:${this._s3Port}`;
    if (service === "events") return `http://127.0.0.1:${this._eventbridgePort}`;
    if (service === "states") return `http://127.0.0.1:${this._stepfunctionsPort}`;
    if (service === "cognito-idp") return `http://127.0.0.1:${this._cognitoPort}`;
    if (service === "lambda") return `http://127.0.0.1:${this._lambdaPort}`;
    throw new Error(
      `Service '${service}' is not available in this session. Currently available: sqs, dynamodb, ssm, secretsmanager, sns, s3, events, states, cognito-idp, lambda`,
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
