"use strict";
/** StepFunctions wire-protocol Fastify plugin. */
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.StepFunctionsStore = void 0;
exports.registerStepFunctions = registerStepFunctions;
const uuid_1 = require("uuid");
const chaos_1 = require("../../middleware/chaos");
const fake_1 = require("../../middleware/fake");
const iam_1 = require("../../middleware/iam");
const logging_1 = require("../../middleware/logging");
const engine_1 = require("./engine");
const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";
class StepFunctionsStore {
    constructor(invoker) {
        this.stateMachines = new Map();
        this.executions = new Map();
        this.tags = new Map();
        this.taskInvoker = invoker ?? {
            async invoke(_resource, input) {
                return input;
            },
        };
    }
    reset() {
        this.stateMachines.clear();
        this.executions.clear();
        this.tags.clear();
    }
    createStateMachine(name, definition, roleArn, type = "STANDARD") {
        const arn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${name}`;
        const def = typeof definition === "string" ? JSON.parse(definition) : definition;
        const sm = {
            name,
            arn,
            definition: def,
            roleArn,
            type,
            status: "ACTIVE",
            creationDate: Date.now() / 1000,
        };
        this.stateMachines.set(arn, sm);
        return sm;
    }
    deleteStateMachine(arn) {
        this.stateMachines.delete(arn);
    }
    describeStateMachine(arn) {
        return this.stateMachines.get(arn);
    }
    listStateMachines() {
        return Array.from(this.stateMachines.values());
    }
    async startExecution(stateMachineArn, input, name) {
        const sm = this.stateMachines.get(stateMachineArn);
        if (!sm)
            throw new Error(`StateMachineDoesNotExist: ${stateMachineArn}`);
        const executionName = name ?? (0, uuid_1.v4)();
        const executionArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:execution:${sm.name}:${executionName}`;
        const execution = {
            executionArn,
            stateMachineArn,
            name: executionName,
            status: "RUNNING",
            startDate: Date.now() / 1000,
            input,
        };
        this.executions.set(executionArn, execution);
        // Run the state machine asynchronously
        const inputData = input ? JSON.parse(input) : {};
        (0, engine_1.runStateMachine)(sm.definition, inputData, executionArn, this.taskInvoker)
            .then((result) => {
            const exec = this.executions.get(executionArn);
            if (!exec)
                return;
            if (result.error) {
                exec.status = "FAILED";
                exec.error = result.error;
                exec.cause = result.cause;
            }
            else {
                exec.status = "SUCCEEDED";
                exec.output = JSON.stringify(result.output);
            }
            exec.stopDate = Date.now() / 1000;
        })
            .catch((err) => {
            const exec = this.executions.get(executionArn);
            if (!exec)
                return;
            exec.status = "FAILED";
            exec.error = "States.Runtime";
            exec.cause = String(err);
            exec.stopDate = Date.now() / 1000;
        });
        return execution;
    }
    describeExecution(executionArn) {
        return this.executions.get(executionArn);
    }
    listExecutions(stateMachineArn) {
        return Array.from(this.executions.values()).filter((e) => e.stateMachineArn === stateMachineArn);
    }
    stopExecution(executionArn) {
        const exec = this.executions.get(executionArn);
        if (exec && (exec.status === "RUNNING" || exec.status === "SUCCEEDED")) {
            exec.status = "ABORTED";
            exec.stopDate = Date.now() / 1000;
        }
    }
    tagResource(arn, tagsArr) {
        const existing = this.tags.get(arn) ?? {};
        for (const t of tagsArr)
            existing[t.key] = t.value;
        this.tags.set(arn, existing);
    }
    untagResource(arn, tagKeys) {
        const existing = this.tags.get(arn) ?? {};
        for (const k of tagKeys)
            delete existing[k];
        this.tags.set(arn, existing);
    }
    listTagsForResource(arn) {
        return this.tags.get(arn) ?? {};
    }
}
exports.StepFunctionsStore = StepFunctionsStore;
function jsonReply(reply, data, status = 200) {
    reply.status(status).header("Content-Type", "application/x-amz-json-1.0").send(data);
}
const TARGET_PREFIX = "AWSStepFunctions.";
function registerStepFunctions(app, state) {
    const store = new StepFunctionsStore();
    state.resetCallbacks.push(() => store.reset());
    app.post("/", async (req, reply) => {
        const target = req.headers["x-amz-target"] ?? "";
        const operation = target.startsWith(TARGET_PREFIX) ? target.slice(TARGET_PREFIX.length) : target;
        const body = req.body;
        const ctx = (0, logging_1.createRequestContext)("stepfunctions", operation);
        if (await (0, iam_1.applyIamAuth)(state, "stepfunctions", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, chaos_1.applyChaos)(state, "stepfunctions", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "stepfunctions", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        try {
            await handleOperation(operation, body, store, reply);
        }
        catch (err) {
            const msg = err instanceof Error ? err.message : String(err);
            if (msg.includes("StateMachineDoesNotExist")) {
                jsonReply(reply, { __type: "StateMachineDoesNotExist", message: msg }, 400);
            }
            else {
                jsonReply(reply, { __type: "InvalidArn", message: msg }, 400);
            }
        }
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    return store;
}
async function handleOperation(operation, body, store, reply) {
    switch (operation) {
        case "CreateStateMachine": {
            const sm = store.createStateMachine(body.name, body.definition, body.roleArn ?? "", body.type ?? "STANDARD");
            jsonReply(reply, {
                stateMachineArn: sm.arn,
                creationDate: sm.creationDate,
            });
            break;
        }
        case "DeleteStateMachine": {
            store.deleteStateMachine(body.stateMachineArn);
            jsonReply(reply, {});
            break;
        }
        case "DescribeStateMachine": {
            const sm = store.describeStateMachine(body.stateMachineArn);
            if (!sm) {
                jsonReply(reply, { __type: "StateMachineDoesNotExist", message: "State machine not found" }, 400);
                return;
            }
            jsonReply(reply, {
                stateMachineArn: sm.arn,
                name: sm.name,
                status: sm.status,
                definition: JSON.stringify(sm.definition),
                roleArn: sm.roleArn,
                type: sm.type,
                creationDate: sm.creationDate,
            });
            break;
        }
        case "ListStateMachines": {
            const machines = store.listStateMachines();
            jsonReply(reply, {
                stateMachines: machines.map((sm) => ({
                    stateMachineArn: sm.arn,
                    name: sm.name,
                    type: sm.type,
                    creationDate: sm.creationDate,
                })),
            });
            break;
        }
        case "StartExecution": {
            const execution = await store.startExecution(body.stateMachineArn, body.input ?? "{}", body.name);
            jsonReply(reply, {
                executionArn: execution.executionArn,
                startDate: execution.startDate,
            });
            break;
        }
        case "DescribeExecution": {
            const execution = store.describeExecution(body.executionArn);
            if (!execution) {
                jsonReply(reply, { __type: "ExecutionDoesNotExist", message: "Execution not found" }, 400);
                return;
            }
            jsonReply(reply, {
                executionArn: execution.executionArn,
                stateMachineArn: execution.stateMachineArn,
                name: execution.name,
                status: execution.status,
                startDate: execution.startDate,
                stopDate: execution.stopDate,
                input: execution.input,
                output: execution.output,
                error: execution.error,
                cause: execution.cause,
            });
            break;
        }
        case "ListExecutions": {
            const executions = store.listExecutions(body.stateMachineArn);
            jsonReply(reply, {
                executions: executions.map((e) => ({
                    executionArn: e.executionArn,
                    stateMachineArn: e.stateMachineArn,
                    name: e.name,
                    status: e.status,
                    startDate: e.startDate,
                    stopDate: e.stopDate,
                })),
            });
            break;
        }
        case "StopExecution": {
            store.stopExecution(body.executionArn);
            jsonReply(reply, { stopDate: Date.now() / 1000 });
            break;
        }
        case "UpdateStateMachine": {
            const sm = store.describeStateMachine(body.stateMachineArn);
            if (!sm) {
                jsonReply(reply, { __type: "StateMachineDoesNotExist", message: "State machine not found" }, 400);
                return;
            }
            if (body.definition) {
                sm.definition = typeof body.definition === "string" ? JSON.parse(body.definition) : body.definition;
            }
            jsonReply(reply, { updateDate: Date.now() / 1000 });
            break;
        }
        case "GetExecutionHistory": {
            const execution = store.describeExecution(body.executionArn);
            if (!execution) {
                jsonReply(reply, { __type: "ExecutionDoesNotExist", message: "Execution not found" }, 400);
                return;
            }
            jsonReply(reply, { events: [] });
            break;
        }
        case "ListStateMachineVersions": {
            // Return empty list - lws does not version state machines
            jsonReply(reply, { stateMachineVersions: [] });
            break;
        }
        case "TagResource": {
            const arn = body.resourceArn;
            const tagsMap = body.tags ?? {};
            const tagsArr = Object.entries(tagsMap).map(([key, value]) => ({ key, value }));
            store.tagResource(arn, tagsArr);
            jsonReply(reply, {});
            break;
        }
        case "UntagResource": {
            const arn = body.resourceArn;
            const tagKeys = body.tagKeys ?? [];
            store.untagResource(arn, tagKeys);
            jsonReply(reply, {});
            break;
        }
        case "ListTagsForResource": {
            const arn = body.resourceArn;
            const tagsMap = store.listTagsForResource(arn);
            jsonReply(reply, { tags: tagsMap });
            break;
        }
        case "StartSyncExecution": {
            // Run synchronously and return result
            const sm = store.describeStateMachine(body.stateMachineArn);
            if (!sm) {
                jsonReply(reply, { __type: "StateMachineDoesNotExist", message: `State machine not found: ${body.stateMachineArn}` }, 400);
                return;
            }
            const inputStr = body.input ?? "{}";
            const inputData = inputStr ? JSON.parse(inputStr) : {};
            const executionArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:express:${sm.name}:${(0, uuid_1.v4)()}`;
            const startDate = Date.now() / 1000;
            try {
                const { runStateMachine: run } = await Promise.resolve().then(() => __importStar(require("./engine")));
                const result = await run(sm.definition, inputData, executionArn, store["taskInvoker"]);
                const stopDate = Date.now() / 1000;
                if (result.error) {
                    jsonReply(reply, {
                        executionArn,
                        stateMachineArn: body.stateMachineArn,
                        name: (0, uuid_1.v4)(),
                        startDate,
                        stopDate,
                        status: "FAILED",
                        error: result.error,
                        cause: result.cause,
                    });
                }
                else {
                    jsonReply(reply, {
                        executionArn,
                        stateMachineArn: body.stateMachineArn,
                        name: (0, uuid_1.v4)(),
                        startDate,
                        stopDate,
                        status: "SUCCEEDED",
                        input: inputStr,
                        output: JSON.stringify(result.output),
                    });
                }
            }
            catch (err) {
                const msg = err instanceof Error ? err.message : String(err);
                jsonReply(reply, {
                    executionArn,
                    stateMachineArn: body.stateMachineArn,
                    name: (0, uuid_1.v4)(),
                    startDate,
                    stopDate: Date.now() / 1000,
                    status: "FAILED",
                    error: "States.Runtime",
                    cause: msg,
                });
            }
            break;
        }
        default: {
            jsonReply(reply, {
                __type: "UnknownOperationException",
                message: `lws: StepFunctions operation '${operation}' not implemented`,
            }, 400);
        }
    }
}
void REGION;
void ACCOUNT_ID;
//# sourceMappingURL=index.js.map