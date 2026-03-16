"use strict";
/** Multi-port Fastify server orchestration. */
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.startServer = startServer;
const fastify_1 = __importDefault(require("fastify"));
const ws_1 = require("ws");
const types_1 = require("./types");
const management_1 = require("./api/management");
const dynamodb_1 = require("./providers/dynamodb");
const sqs_1 = require("./providers/sqs");
const s3_1 = require("./providers/s3");
const sns_1 = require("./providers/sns");
const eventbridge_1 = require("./providers/eventbridge");
const stepfunctions_1 = require("./providers/stepfunctions");
const ssm_1 = require("./providers/ssm");
const secretsmanager_1 = require("./providers/secretsmanager");
const cognitoidp_1 = require("./providers/cognitoidp");
// Port offsets — must match SDK's SERVICE_OFFSETS
const SERVICE_OFFSETS = {
    dynamodb: 1,
    sqs: 2,
    s3: 3,
    sns: 4,
    eventbridge: 5,
    stepfunctions: 6,
    cognitoidp: 7,
    ssm: 12,
    secretsmanager: 13,
};
function createApp(rawBody = false) {
    const app = (0, fastify_1.default)({
        logger: false,
        disableRequestLogging: true,
    });
    if (rawBody) {
        // S3 needs raw bytes for object bodies
        app.addContentTypeParser("*", { parseAs: "buffer" }, (_req, body, done) => {
            done(null, body);
        });
    }
    else {
        // Parse AWS JSON content types
        app.addContentTypeParser(["application/x-amz-json-1.0", "application/x-amz-json-1.1", "application/json"], { parseAs: "string" }, (_req, body, done) => {
            try {
                done(null, body ? JSON.parse(body) : {});
            }
            catch {
                done(new Error("Invalid JSON"), undefined);
            }
        });
    }
    return app;
}
async function startServer(config) {
    const { basePort, host = "127.0.0.1" } = config;
    const state = (0, types_1.createServerState)();
    const apps = [];
    const ports = {};
    // ── Management server (base port) ─────────────────────────────────────────
    const mgmtApp = createApp();
    apps.push(mgmtApp);
    const wsServer = new ws_1.WebSocketServer({ noServer: true });
    (0, management_1.registerManagementApi)(mgmtApp, state, wsServer);
    await mgmtApp.listen({ port: basePort, host });
    // ── Service servers ────────────────────────────────────────────────────────
    const serviceApps = [];
    // DynamoDB
    {
        const app = createApp();
        await app.register(async (instance) => (0, dynamodb_1.registerDynamoDb)(instance, state));
        const port = basePort + SERVICE_OFFSETS.dynamodb;
        serviceApps.push({ name: "dynamodb", app, port });
    }
    // SQS
    {
        const sqsPort = basePort + SERVICE_OFFSETS.sqs;
        const app = createApp();
        await app.register(async (instance) => (0, sqs_1.registerSqs)(instance, state, sqsPort));
        serviceApps.push({ name: "sqs", app, port: sqsPort });
    }
    // S3 (uses raw body parsing)
    {
        const app = createApp(true);
        await app.register(async (instance) => (0, s3_1.registerS3)(instance, state));
        const port = basePort + SERVICE_OFFSETS.s3;
        serviceApps.push({ name: "s3", app, port });
    }
    // SNS
    {
        const app = createApp();
        await app.register(async (instance) => (0, sns_1.registerSns)(instance, state));
        const port = basePort + SERVICE_OFFSETS.sns;
        serviceApps.push({ name: "sns", app, port });
    }
    // EventBridge
    {
        const app = createApp();
        await app.register(async (instance) => (0, eventbridge_1.registerEventBridge)(instance, state));
        const port = basePort + SERVICE_OFFSETS.eventbridge;
        serviceApps.push({ name: "eventbridge", app, port });
    }
    // StepFunctions
    {
        const app = createApp();
        await app.register(async (instance) => (0, stepfunctions_1.registerStepFunctions)(instance, state));
        const port = basePort + SERVICE_OFFSETS.stepfunctions;
        serviceApps.push({ name: "stepfunctions", app, port });
    }
    // Cognito IDP
    {
        const app = createApp();
        await app.register(async (instance) => (0, cognitoidp_1.registerCognitoIdp)(instance, state));
        const port = basePort + SERVICE_OFFSETS.cognitoidp;
        serviceApps.push({ name: "cognitoidp", app, port });
    }
    // SSM
    {
        const app = createApp();
        await app.register(async (instance) => (0, ssm_1.registerSsm)(instance, state));
        const port = basePort + SERVICE_OFFSETS.ssm;
        serviceApps.push({ name: "ssm", app, port });
    }
    // SecretsManager
    {
        const app = createApp();
        await app.register(async (instance) => (0, secretsmanager_1.registerSecretsManager)(instance, state));
        const port = basePort + SERVICE_OFFSETS.secretsmanager;
        serviceApps.push({ name: "secretsmanager", app, port });
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
//# sourceMappingURL=server.js.map