/** StepFunctions wire-protocol Fastify plugin. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { isExhausted } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";
import {
  runStateMachine,
  type StateMachineDefinition,
  type Execution,
  type TaskInvoker,
} from "./engine";
import type { DynamoStore } from "../dynamodb/store";
import type { SqsStore } from "../sqs";
import type { SnsStore } from "../sns";
import type { S3Store } from "../s3";
import type { SecretsManagerStore } from "../secretsmanager";
import type { SsmStore } from "../ssm";
import type { EventBridgeStore } from "../eventbridge";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

// ─── Service integration ARN patterns ────────────────────────────────────────
// Resource ARNs of the form: arn:aws:states:::service:operation

interface ServiceStores {
  dynamodb?: DynamoStore;
  sqs?: SqsStore;
  sns?: SnsStore;
  s3?: S3Store;
  secretsmanager?: SecretsManagerStore;
  ssm?: SsmStore;
  eventbridge?: EventBridgeStore;
}

/**
 * ServiceTaskInvoker handles service integration ARNs
 * (arn:aws:states:::service:operation) and delegates to the
 * appropriate in-process provider store.
 */
export class ServiceTaskInvoker implements TaskInvoker {
  private stores: ServiceStores;

  constructor(stores: ServiceStores = {}) {
    this.stores = stores;
  }

  async invoke(resource: string, input: unknown): Promise<unknown> {
    const params = input as Record<string, unknown>;

    // Service integration ARNs: arn:aws:states:::service:operation[.sync]
    if (resource.startsWith("arn:aws:states:::")) {
      const suffix = resource.slice("arn:aws:states:::".length);
      // Strip optional sync/waitForTaskToken qualifiers (e.g., ".sync", ".sync:2", ".waitForTaskToken")
      const colonIdx = suffix.indexOf(":");
      if (colonIdx !== -1) {
        const service = suffix.slice(0, colonIdx);
        const operationWithQualifier = suffix.slice(colonIdx + 1);
        // Strip qualifier after first "." if present
        const dotIdx = operationWithQualifier.indexOf(".");
        const operation =
          dotIdx !== -1 ? operationWithQualifier.slice(0, dotIdx) : operationWithQualifier;
        return this.invokeServiceIntegration(service, operation, params);
      }
    }

    // Fall through: Lambda ARNs or unknown resources — return input unchanged
    return input;
  }

  private invokeServiceIntegration(
    service: string,
    operation: string,
    params: Record<string, unknown>,
  ): unknown {
    switch (service) {
      case "dynamodb":
        return this.invokeDynamoDb(operation, params);
      case "sqs":
        return this.invokeSqs(operation, params);
      case "sns":
        return this.invokeSns(operation, params);
      case "s3":
        return this.invokeS3(operation, params);
      case "secretsmanager":
        return this.invokeSecretsManager(operation, params);
      case "ssm":
        return this.invokeSsm(operation, params);
      case "events":
        return this.invokeEventBridge(operation, params);
      default:
        // Unknown service integration — return params unchanged
        return params;
    }
  }

  private invokeDynamoDb(operation: string, params: Record<string, unknown>): unknown {
    const store = this.stores.dynamodb;
    if (!store) return params;
    switch (operation) {
      case "putItem": {
        store.putItem(params.TableName as string, params.Item as Record<string, unknown>);
        return {};
      }
      case "getItem": {
        const item = store.getItem(
          params.TableName as string,
          params.Key as Record<string, unknown>,
        );
        return item ? { Item: item } : {};
      }
      default:
        return params;
    }
  }

  private invokeSqs(operation: string, params: Record<string, unknown>): unknown {
    const store = this.stores.sqs;
    if (!store) return params;
    switch (operation) {
      case "sendMessage": {
        const queue = store.getQueue(params.QueueUrl as string);
        if (!queue) throw new Error(`Queue not found: ${params.QueueUrl as string}`);
        const messageId = queue.sendMessage(params.MessageBody as string);
        const { createHash } = require("crypto") as typeof import("crypto");
        const md5 = createHash("md5")
          .update(params.MessageBody as string)
          .digest("hex");
        return { MessageId: messageId, MD5OfMessageBody: md5 };
      }
      default:
        return params;
    }
  }

  private invokeSns(operation: string, params: Record<string, unknown>): unknown {
    const store = this.stores.sns;
    if (!store) return params;
    switch (operation) {
      case "publish": {
        const messageId = store.publish(
          params.TopicArn as string,
          params.Message as string,
          params.Subject as string | undefined,
        );
        return { MessageId: messageId };
      }
      default:
        return params;
    }
  }

  private invokeS3(operation: string, params: Record<string, unknown>): unknown {
    const store = this.stores.s3;
    if (!store) return params;
    switch (operation) {
      case "getObject": {
        const obj = store.getObject(params.Bucket as string, params.Key as string);
        if (!obj) throw new Error(`NoSuchKey: ${params.Key as string}`);
        return { Body: obj.body.toString(), ContentType: obj.contentType };
      }
      case "putObject": {
        const body =
          typeof params.Body === "string"
            ? Buffer.from(params.Body)
            : Buffer.isBuffer(params.Body)
              ? (params.Body as Buffer)
              : Buffer.from(JSON.stringify(params.Body));
        const contentType =
          (params.ContentType as string | undefined) ?? "application/octet-stream";
        store.putObject(params.Bucket as string, params.Key as string, body, {
          "content-type": contentType,
        });
        return {};
      }
      default:
        return params;
    }
  }

  private invokeSecretsManager(operation: string, params: Record<string, unknown>): unknown {
    const store = this.stores.secretsmanager;
    if (!store) return params;
    switch (operation) {
      case "getSecretValue": {
        const secret = store.getSecret(params.SecretId as string);
        if (!secret)
          throw new Error(
            `ResourceNotFoundException: Secret ${params.SecretId as string} not found`,
          );
        const result: Record<string, unknown> = {
          ARN: secret.arn,
          Name: secret.name,
          VersionId: secret.versionId,
        };
        if (secret.secretString !== undefined) result.SecretString = secret.secretString;
        if (secret.secretBinary !== undefined) result.SecretBinary = secret.secretBinary;
        return result;
      }
      default:
        return params;
    }
  }

  private invokeSsm(operation: string, params: Record<string, unknown>): unknown {
    const store = this.stores.ssm;
    if (!store) return params;
    switch (operation) {
      case "getParameter": {
        const param = store.getParameter(params.Name as string, params.WithDecryption as boolean);
        if (!param) throw new Error(`ParameterNotFound: ${params.Name as string}`);
        return {
          Parameter: {
            Name: param.name,
            Value: param.value,
            Type: param.type,
            Version: param.version,
            ARN: param.arn,
          },
        };
      }
      default:
        return params;
    }
  }

  private invokeEventBridge(operation: string, params: Record<string, unknown>): unknown {
    const store = this.stores.eventbridge;
    if (!store) return params;
    switch (operation) {
      case "putEvents": {
        const entries = (params.Entries as Array<Record<string, unknown>>) ?? [];
        const busName = (entries[0]?.EventBusName as string) ?? "default";
        store.putEvents(busName, entries);
        return {
          FailedEntryCount: 0,
          Entries: entries.map(() => ({ EventId: uuidv4() })),
        };
      }
      default:
        return params;
    }
  }
}

interface StateMachine {
  name: string;
  arn: string;
  definition: StateMachineDefinition;
  roleArn: string;
  type: string;
  status: string;
  creationDate: number;
}

export class StepFunctionsStore {
  private stateMachines: Map<string, StateMachine> = new Map();
  private executions: Map<string, Execution> = new Map();
  private taskInvoker: TaskInvoker;
  private tags: Map<string, Record<string, string>> = new Map();

  constructor(invoker?: TaskInvoker) {
    this.taskInvoker = invoker ?? new ServiceTaskInvoker();
  }

  setServiceStores(stores: ServiceStores): void {
    // Replace the task invoker with a new ServiceTaskInvoker wired to the given stores.
    // This is the primary wiring point called by server.ts after all stores are created.
    this.taskInvoker = new ServiceTaskInvoker(stores);
  }

  reset(): void {
    this.stateMachines.clear();
    this.executions.clear();
    this.tags.clear();
  }

  createStateMachine(
    name: string,
    definition: string | StateMachineDefinition,
    roleArn: string,
    type: string = "STANDARD",
  ): StateMachine {
    const arn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${name}`;
    if (this.stateMachines.has(arn)) {
      throw new Error(`StateMachineAlreadyExists: ${name}`);
    }
    const def: StateMachineDefinition =
      typeof definition === "string" ? JSON.parse(definition) : definition;
    const sm: StateMachine = {
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

  deleteStateMachine(arn: string): void {
    this.stateMachines.delete(arn);
  }

  describeStateMachine(arn: string): StateMachine | undefined {
    return this.stateMachines.get(arn);
  }

  listStateMachines(): StateMachine[] {
    return Array.from(this.stateMachines.values());
  }

  async startExecution(stateMachineArn: string, input: string, name?: string): Promise<Execution> {
    const sm = this.stateMachines.get(stateMachineArn);
    if (!sm) throw new Error(`StateMachineDoesNotExist: ${stateMachineArn}`);

    const executionName = name ?? uuidv4();
    const executionArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:execution:${sm.name}:${executionName}`;

    const execution: Execution = {
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
    runStateMachine(sm.definition, inputData, executionArn, this.taskInvoker)
      .then((result) => {
        const exec = this.executions.get(executionArn);
        if (!exec) return;
        if (result.error) {
          exec.status = "FAILED";
          exec.error = result.error;
          exec.cause = result.cause;
        } else {
          exec.status = "SUCCEEDED";
          exec.output = JSON.stringify(result.output);
        }
        exec.stopDate = Date.now() / 1000;
      })
      .catch((err) => {
        const exec = this.executions.get(executionArn);
        if (!exec) return;
        exec.status = "FAILED";
        exec.error = "States.Runtime";
        exec.cause = String(err);
        exec.stopDate = Date.now() / 1000;
      });

    return execution;
  }

  describeExecution(executionArn: string): Execution | undefined {
    return this.executions.get(executionArn);
  }

  listExecutions(stateMachineArn: string): Execution[] {
    return Array.from(this.executions.values()).filter(
      (e) => e.stateMachineArn === stateMachineArn,
    );
  }

  stopExecution(executionArn: string): void {
    const exec = this.executions.get(executionArn);
    if (exec && (exec.status === "RUNNING" || exec.status === "SUCCEEDED")) {
      exec.status = "ABORTED";
      exec.stopDate = Date.now() / 1000;
    }
  }

  tagResource(arn: string, tagsArr: Array<{ key: string; value: string }>): void {
    const existing = this.tags.get(arn) ?? {};
    for (const t of tagsArr) existing[t.key] = t.value;
    this.tags.set(arn, existing);
  }

  untagResource(arn: string, tagKeys: string[]): void {
    const existing = this.tags.get(arn) ?? {};
    for (const k of tagKeys) delete existing[k];
    this.tags.set(arn, existing);
  }

  listTagsForResource(arn: string): Record<string, string> {
    return this.tags.get(arn) ?? {};
  }
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/x-amz-json-1.0").send(data);
}

const TARGET_PREFIX = "AWSStepFunctions.";

export function registerStepFunctions(
  app: FastifyInstance,
  state: ServerState,
): StepFunctionsStore {
  const store = new StepFunctionsStore();
  state.resetCallbacks.push(() => store.reset());
  // Register ARN existence checker for state machines
  state.arnExistsCheckers.set(
    "states",
    (arn: string) => store.describeStateMachine(arn) !== undefined,
  );

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    const operation = target.startsWith(TARGET_PREFIX)
      ? target.slice(TARGET_PREFIX.length)
      : target;
    const body = req.body as Record<string, unknown>;
    const ctx = createRequestContext("stepfunctions", operation);

    if (await applyIamAuth(state, "states", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "stepfunctions", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "stepfunctions", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    if (
      operation === "StartExecution" &&
      isExhausted(state.capacityConfigs["stepfunctions"] ?? { slots: null })
    ) {
      jsonReply(
        reply,
        {
          __type: "ExecutionLimitExceeded",
          message: "No execution slot available",
        },
        400,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    try {
      await handleOperation(operation, body, store, reply);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.includes("StateMachineAlreadyExists")) {
        const name = msg.replace(/^StateMachineAlreadyExists:\s*/, "");
        jsonReply(
          reply,
          {
            __type: "StateMachineAlreadyExists",
            message: `State Machine Already Exists: '${name}'`,
          },
          400,
        );
      } else if (msg.includes("StateMachineDoesNotExist")) {
        jsonReply(reply, { __type: "StateMachineDoesNotExist", message: msg }, 400);
      } else {
        jsonReply(reply, { __type: "InvalidArn", message: msg }, 400);
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  return store;
}

async function handleOperation(
  operation: string,
  body: Record<string, unknown>,
  store: StepFunctionsStore,
  reply: FastifyReply,
): Promise<void> {
  switch (operation) {
    case "CreateStateMachine": {
      const sm = store.createStateMachine(
        body.name as string,
        body.definition as string,
        (body.roleArn as string) ?? "",
        (body.type as string) ?? "STANDARD",
      );
      jsonReply(reply, {
        stateMachineArn: sm.arn,
        creationDate: sm.creationDate,
      });
      break;
    }

    case "DeleteStateMachine": {
      const sm = store.describeStateMachine(body.stateMachineArn as string);
      if (!sm) {
        jsonReply(
          reply,
          { __type: "StateMachineDoesNotExist", message: "State machine not found" },
          400,
        );
        return;
      }
      store.deleteStateMachine(body.stateMachineArn as string);
      jsonReply(reply, {});
      break;
    }

    case "DescribeStateMachine": {
      const sm = store.describeStateMachine(body.stateMachineArn as string);
      if (!sm) {
        jsonReply(
          reply,
          { __type: "StateMachineDoesNotExist", message: "State machine not found" },
          400,
        );
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
      const execution = await store.startExecution(
        body.stateMachineArn as string,
        (body.input as string) ?? "{}",
        body.name as string | undefined,
      );
      jsonReply(reply, {
        executionArn: execution.executionArn,
        startDate: execution.startDate,
      });
      break;
    }

    case "DescribeExecution": {
      const execution = store.describeExecution(body.executionArn as string);
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
      const smForList = store.describeStateMachine(body.stateMachineArn as string);
      if (!smForList) {
        jsonReply(
          reply,
          { __type: "StateMachineDoesNotExist", message: "State machine not found" },
          400,
        );
        return;
      }
      const executions = store.listExecutions(body.stateMachineArn as string);
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
      const execForStop = store.describeExecution(body.executionArn as string);
      if (!execForStop) {
        jsonReply(reply, { __type: "ExecutionDoesNotExist", message: "Execution not found" }, 400);
        return;
      }
      store.stopExecution(body.executionArn as string);
      jsonReply(reply, { stopDate: Date.now() / 1000 });
      break;
    }

    case "UpdateStateMachine": {
      const sm = store.describeStateMachine(body.stateMachineArn as string);
      if (!sm) {
        jsonReply(
          reply,
          { __type: "StateMachineDoesNotExist", message: "State machine not found" },
          400,
        );
        return;
      }
      if (body.definition) {
        sm.definition =
          typeof body.definition === "string"
            ? JSON.parse(body.definition as string)
            : (body.definition as StateMachineDefinition);
      }
      jsonReply(reply, { updateDate: Date.now() / 1000 });
      break;
    }

    case "GetExecutionHistory": {
      const execution = store.describeExecution(body.executionArn as string);
      if (!execution) {
        jsonReply(reply, { __type: "ExecutionDoesNotExist", message: "Execution not found" }, 400);
        return;
      }
      jsonReply(reply, { events: [] });
      break;
    }

    case "ListStateMachineVersions": {
      const smForVersions = store.describeStateMachine(body.stateMachineArn as string);
      if (!smForVersions) {
        jsonReply(
          reply,
          { __type: "StateMachineDoesNotExist", message: "State machine not found" },
          400,
        );
        return;
      }
      // Return empty list - lws does not version state machines
      jsonReply(reply, { stateMachineVersions: [] });
      break;
    }

    case "TagResource": {
      const arn = body.resourceArn as string;
      if (arn.includes(":stateMachine:")) {
        const sm = store.describeStateMachine(arn);
        if (!sm) {
          jsonReply(reply, { __type: "ResourceNotFound", message: "Resource not found" }, 400);
          return;
        }
      }
      const tagsRaw = body.tags ?? [];
      const tagsArr: Array<{ key: string; value: string }> = Array.isArray(tagsRaw)
        ? (tagsRaw as Array<{ key: string; value: string }>)
        : Object.entries(tagsRaw as Record<string, string>).map(([key, value]) => ({ key, value }));
      store.tagResource(arn, tagsArr);
      jsonReply(reply, {});
      break;
    }

    case "UntagResource": {
      const arn = body.resourceArn as string;
      if (arn.includes(":stateMachine:")) {
        const sm = store.describeStateMachine(arn);
        if (!sm) {
          jsonReply(reply, { __type: "ResourceNotFound", message: "Resource not found" }, 400);
          return;
        }
      }
      const tagKeys = (body.tagKeys as string[]) ?? [];
      const currentTags = store.listTagsForResource(arn);
      const missingKeys = tagKeys.filter((k) => !(k in currentTags));
      if (missingKeys.length > 0) {
        jsonReply(
          reply,
          { __type: "ResourceNotFound", message: `Tag not associated: ${missingKeys[0]}` },
          400,
        );
        return;
      }
      store.untagResource(arn, tagKeys);
      jsonReply(reply, {});
      break;
    }

    case "ListTagsForResource": {
      const arn = body.resourceArn as string;
      if (arn.includes(":stateMachine:")) {
        const sm = store.describeStateMachine(arn);
        if (!sm) {
          jsonReply(reply, { __type: "ResourceNotFound", message: "Resource not found" }, 400);
          return;
        }
      }
      const tagsMap = store.listTagsForResource(arn);
      jsonReply(reply, { tags: tagsMap });
      break;
    }

    case "StartSyncExecution": {
      // Run synchronously and return result
      const sm = store.describeStateMachine(body.stateMachineArn as string);
      if (!sm) {
        jsonReply(
          reply,
          {
            __type: "StateMachineDoesNotExist",
            message: `State machine not found: ${body.stateMachineArn}`,
          },
          400,
        );
        return;
      }
      const inputStr = (body.input as string) ?? "{}";
      const inputData = inputStr ? JSON.parse(inputStr) : {};
      const executionArn = `arn:aws:states:${REGION}:${ACCOUNT_ID}:express:${sm.name}:${uuidv4()}`;
      const startDate = Date.now() / 1000;
      try {
        const { runStateMachine: run } = await import("./engine");
        const result = await run(sm.definition, inputData, executionArn, store["taskInvoker"]);
        const stopDate = Date.now() / 1000;
        if (result.error) {
          jsonReply(reply, {
            executionArn,
            stateMachineArn: body.stateMachineArn,
            name: uuidv4(),
            startDate,
            stopDate,
            status: "FAILED",
            error: result.error,
            cause: result.cause,
          });
        } else {
          jsonReply(reply, {
            executionArn,
            stateMachineArn: body.stateMachineArn,
            name: uuidv4(),
            startDate,
            stopDate,
            status: "SUCCEEDED",
            input: inputStr,
            output: JSON.stringify(result.output),
          });
        }
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        jsonReply(reply, {
          executionArn,
          stateMachineArn: body.stateMachineArn,
          name: uuidv4(),
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
      jsonReply(
        reply,
        {
          __type: "UnknownOperationException",
          message: `lws: StepFunctions operation '${operation}' not implemented`,
        },
        400,
      );
    }
  }
}

void REGION;
void ACCOUNT_ID;
