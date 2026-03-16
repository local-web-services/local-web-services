/** StepFunctions wire-protocol Fastify plugin. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
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

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

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
    this.taskInvoker = invoker ?? {
      async invoke(_resource: string, input: unknown): Promise<unknown> {
        return input;
      },
    };
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
    type: string = "STANDARD"
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

  async startExecution(
    stateMachineArn: string,
    input: string,
    name?: string
  ): Promise<Execution> {
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
      (e) => e.stateMachineArn === stateMachineArn
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

export function registerStepFunctions(app: FastifyInstance, state: ServerState): StepFunctionsStore {
  const store = new StepFunctionsStore();
  state.resetCallbacks.push(() => store.reset());
  // Register ARN existence checker for state machines
  state.arnExistsCheckers.set("states", (arn: string) => store.describeStateMachine(arn) !== undefined);

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    const operation = target.startsWith(TARGET_PREFIX) ? target.slice(TARGET_PREFIX.length) : target;
    const body = req.body as Record<string, unknown>;
    const ctx = createRequestContext("stepfunctions", operation);

    if (await applyIamAuth(state, "stepfunctions", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode); return;
    }
    if (await applyChaos(state, "stepfunctions", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode); return;
    }
    if (await applyFake(state, "stepfunctions", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode); return;
    }

    try {
      await handleOperation(operation, body, store, reply);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.includes("StateMachineAlreadyExists")) {
        const name = msg.replace(/^StateMachineAlreadyExists:\s*/, "");
        jsonReply(reply, { __type: "StateMachineAlreadyExists", message: `State Machine Already Exists: '${name}'` }, 400);
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
  reply: FastifyReply
): Promise<void> {
  switch (operation) {
    case "CreateStateMachine": {
      const sm = store.createStateMachine(
        body.name as string,
        body.definition as string,
        (body.roleArn as string) ?? "",
        (body.type as string) ?? "STANDARD"
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
        jsonReply(reply, { __type: "StateMachineDoesNotExist", message: "State machine not found" }, 400);
        return;
      }
      store.deleteStateMachine(body.stateMachineArn as string);
      jsonReply(reply, {});
      break;
    }

    case "DescribeStateMachine": {
      const sm = store.describeStateMachine(body.stateMachineArn as string);
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
      const execution = await store.startExecution(
        body.stateMachineArn as string,
        (body.input as string) ?? "{}",
        body.name as string | undefined
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
        jsonReply(reply, { __type: "StateMachineDoesNotExist", message: "State machine not found" }, 400);
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
        jsonReply(reply, { __type: "StateMachineDoesNotExist", message: "State machine not found" }, 400);
        return;
      }
      if (body.definition) {
        sm.definition = typeof body.definition === "string" ? JSON.parse(body.definition as string) : body.definition as StateMachineDefinition;
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
        jsonReply(reply, { __type: "StateMachineDoesNotExist", message: "State machine not found" }, 400);
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
        jsonReply(reply, { __type: "ResourceNotFound", message: `Tag not associated: ${missingKeys[0]}` }, 400);
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
        jsonReply(reply, { __type: "StateMachineDoesNotExist", message: `State machine not found: ${body.stateMachineArn}` }, 400);
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
      jsonReply(reply, {
        __type: "UnknownOperationException",
        message: `lws: StepFunctions operation '${operation}' not implemented`,
      }, 400);
    }
  }
}

void REGION; void ACCOUNT_ID;
