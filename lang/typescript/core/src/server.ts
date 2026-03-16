/** Multi-port Fastify server orchestration. */

import Fastify, { type FastifyInstance } from "fastify";
import { WebSocketServer } from "ws";
import { createServerState, type ServerState } from "./types";
import { registerManagementApi } from "./api/management";
import { registerDynamoDb } from "./providers/dynamodb";
import { registerSqs } from "./providers/sqs";
import { registerS3 } from "./providers/s3";
import { registerSns } from "./providers/sns";
import { registerEventBridge } from "./providers/eventbridge";
import { registerStepFunctions } from "./providers/stepfunctions";
import { registerSsm } from "./providers/ssm";
import { registerSecretsManager } from "./providers/secretsmanager";
import { registerCognitoIdp } from "./providers/cognitoidp";
import { registerLambda } from "./providers/lambda";
import { registerApiGateway } from "./providers/apigateway";
import { registerRds } from "./providers/rds";
import { registerDocDb } from "./providers/docdb";
import { registerElastiCache } from "./providers/elasticache";
import { registerNeptune } from "./providers/neptune";
import { registerMemoryDb } from "./providers/memorydb";
import { registerGlacier } from "./providers/glacier";
import { registerElasticsearch } from "./providers/elasticsearch";
import { registerOpenSearch } from "./providers/opensearch";
import { registerS3Tables } from "./providers/s3tables";

export interface LwsServerConfig {
  basePort: number;
  host?: string;
}

export interface LwsServer {
  state: ServerState;
  managementUrl: string;
  ports: Record<string, number>;
  close(): Promise<void>;
}

// Port offsets — must match SDK's SERVICE_OFFSETS
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

function createApp(rawBody = false): FastifyInstance {
  const app = Fastify({
    logger: false,
    disableRequestLogging: true,
  });

  if (rawBody) {
    // S3 needs raw bytes for object bodies
    app.addContentTypeParser("*", { parseAs: "buffer" }, (_req, body, done) => {
      done(null, body);
    });
  } else {
    // Parse AWS JSON content types
    app.addContentTypeParser(
      ["application/x-amz-json-1.0", "application/x-amz-json-1.1", "application/json"],
      { parseAs: "string" },
      (_req, body, done) => {
        try {
          done(null, body ? JSON.parse(body as string) : {});
        } catch {
          done(new Error("Invalid JSON"), undefined);
        }
      }
    );
  }

  return app;
}

export async function startServer(config: LwsServerConfig): Promise<LwsServer> {
  const { basePort, host = "127.0.0.1" } = config;
  const state = createServerState();

  const apps: Array<FastifyInstance> = [];
  const ports: Record<string, number> = {};

  // ── Management server (base port) ─────────────────────────────────────────
  const mgmtApp = createApp();
  apps.push(mgmtApp);

  const wsServer = new WebSocketServer({ noServer: true });
  registerManagementApi(mgmtApp, state, wsServer);

  await mgmtApp.listen({ port: basePort, host });

  // ── Service servers ────────────────────────────────────────────────────────
  const serviceApps: Array<{ name: string; app: FastifyInstance; port: number }> = [];

  // DynamoDB
  {
    const app = createApp();
    await app.register(async (instance) => registerDynamoDb(instance, state));
    const port = basePort + SERVICE_OFFSETS.dynamodb;
    serviceApps.push({ name: "dynamodb", app, port });
  }

  // SQS
  {
    const sqsPort = basePort + SERVICE_OFFSETS.sqs;
    const app = createApp();
    await app.register(async (instance) => registerSqs(instance, state, sqsPort));
    serviceApps.push({ name: "sqs", app, port: sqsPort });
  }

  // S3 (uses raw body parsing)
  {
    const app = createApp(true);
    await app.register(async (instance) => registerS3(instance, state));
    const port = basePort + SERVICE_OFFSETS.s3;
    serviceApps.push({ name: "s3", app, port });
  }

  // SNS
  {
    const app = createApp();
    await app.register(async (instance) => registerSns(instance, state));
    const port = basePort + SERVICE_OFFSETS.sns;
    serviceApps.push({ name: "sns", app, port });
  }

  // EventBridge
  {
    const app = createApp();
    await app.register(async (instance) => registerEventBridge(instance, state));
    const port = basePort + SERVICE_OFFSETS.eventbridge;
    serviceApps.push({ name: "eventbridge", app, port });
  }

  // StepFunctions
  {
    const app = createApp();
    await app.register(async (instance) => registerStepFunctions(instance, state));
    const port = basePort + SERVICE_OFFSETS.stepfunctions;
    serviceApps.push({ name: "stepfunctions", app, port });
  }

  // Cognito IDP
  {
    const app = createApp();
    await app.register(async (instance) => registerCognitoIdp(instance, state));
    const port = basePort + SERVICE_OFFSETS.cognitoidp;
    serviceApps.push({ name: "cognitoidp", app, port });
  }

  // Lambda
  {
    const app = createApp();
    await app.register(async (instance) => registerLambda(instance, state));
    const port = basePort + SERVICE_OFFSETS.lambda;
    serviceApps.push({ name: "lambda", app, port });
  }

  // API Gateway
  {
    const app = createApp();
    await app.register(async (instance) => registerApiGateway(instance, state));
    const port = basePort + SERVICE_OFFSETS.apigateway;
    serviceApps.push({ name: "apigateway", app, port });
  }

  // SSM
  {
    const app = createApp();
    await app.register(async (instance) => registerSsm(instance, state));
    const port = basePort + SERVICE_OFFSETS.ssm;
    serviceApps.push({ name: "ssm", app, port });
  }

  // SecretsManager
  {
    const app = createApp();
    await app.register(async (instance) => registerSecretsManager(instance, state));
    const port = basePort + SERVICE_OFFSETS.secretsmanager;
    serviceApps.push({ name: "secretsmanager", app, port });
  }

  // RDS
  {
    const app = createApp();
    await app.register(async (instance) => registerRds(instance, state));
    const port = basePort + SERVICE_OFFSETS.rds;
    serviceApps.push({ name: "rds", app, port });
  }

  // DocDB
  {
    const app = createApp();
    await app.register(async (instance) => registerDocDb(instance, state));
    const port = basePort + SERVICE_OFFSETS.docdb;
    serviceApps.push({ name: "docdb", app, port });
  }

  // ElastiCache
  {
    const app = createApp();
    await app.register(async (instance) => registerElastiCache(instance, state));
    const port = basePort + SERVICE_OFFSETS.elasticache;
    serviceApps.push({ name: "elasticache", app, port });
  }

  // Neptune
  {
    const app = createApp();
    await app.register(async (instance) => registerNeptune(instance, state));
    const port = basePort + SERVICE_OFFSETS.neptune;
    serviceApps.push({ name: "neptune", app, port });
  }

  // MemoryDB
  {
    const app = createApp();
    await app.register(async (instance) => registerMemoryDb(instance, state));
    const port = basePort + SERVICE_OFFSETS.memorydb;
    serviceApps.push({ name: "memorydb", app, port });
  }

  // Glacier
  {
    const app = createApp();
    await app.register(async (instance) => registerGlacier(instance, state));
    const port = basePort + SERVICE_OFFSETS.glacier;
    serviceApps.push({ name: "glacier", app, port });
  }

  // Elasticsearch
  {
    const app = createApp();
    await app.register(async (instance) => registerElasticsearch(instance, state));
    const port = basePort + SERVICE_OFFSETS.elasticsearch;
    serviceApps.push({ name: "elasticsearch", app, port });
  }

  // OpenSearch
  {
    const app = createApp();
    await app.register(async (instance) => registerOpenSearch(instance, state));
    const port = basePort + SERVICE_OFFSETS.opensearch;
    serviceApps.push({ name: "opensearch", app, port });
  }

  // S3 Tables
  {
    const app = createApp();
    await app.register(async (instance) => registerS3Tables(instance, state));
    const port = basePort + SERVICE_OFFSETS.s3tables;
    serviceApps.push({ name: "s3tables", app, port });
  }

  // Start all service apps
  for (const { name, app, port } of serviceApps) {
    await app.listen({ port, host });
    ports[name] = port;
    apps.push(app);
  }

  return {
    state,
    managementUrl: `http://${host}:${basePort}`,
    ports,
    async close() {
      wsServer.close();
      for (const app of apps) {
        await app.close();
      }
    },
  };
}
