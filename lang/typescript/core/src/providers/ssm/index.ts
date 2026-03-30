/** SSM wire-protocol Fastify plugin (JSON API). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";
import type { EventBridgeStore } from "../eventbridge";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

interface SsmParameter {
  name: string;
  value: string;
  type: string;
  version: number;
  arn: string;
  description?: string;
  lastModifiedDate: number;
  createdAt: number;
  tags: Record<string, string>;
}

export class SsmStore {
  private params: Map<string, SsmParameter> = new Map();
  private eventBridgeStore: EventBridgeStore | null = null;
  private eventBridgeBusName: string = "default";

  setEventBridgeStore(store: EventBridgeStore): void {
    this.eventBridgeStore = store;
  }

  setEventBridgeBusName(busName: string): void {
    this.eventBridgeBusName = busName;
  }

  reset(): void {
    this.params.clear();
  }

  putParameter(
    name: string,
    value: string,
    type: string = "String",
    description?: string,
  ): SsmParameter {
    const existing = this.params.get(name);
    const param: SsmParameter = {
      name,
      value,
      type,
      version: (existing?.version ?? 0) + 1,
      arn: `arn:aws:ssm:${REGION}:${ACCOUNT_ID}:parameter${name}`,
      description,
      lastModifiedDate: Date.now() / 1000,
      createdAt: existing?.createdAt ?? Date.now(),
      tags: existing?.tags ?? {},
    };
    this.params.set(name, param);
    return param;
  }

  getParameter(name: string, withDecryption?: boolean): SsmParameter | undefined {
    void withDecryption;
    return this.params.get(name);
  }

  getParametersByPath(path: string): SsmParameter[] {
    return Array.from(this.params.values()).filter((p) => p.name.startsWith(path));
  }

  deleteParameter(name: string): void {
    this.params.delete(name);
  }

  addTags(name: string, tags: Array<{ Key: string; Value: string }>): void {
    const param = this.params.get(name);
    if (param) {
      for (const tag of tags) param.tags[tag.Key] = tag.Value;
    }
  }

  removeTags(name: string, tagKeys: string[]): void {
    const param = this.params.get(name);
    if (param) {
      for (const key of tagKeys) delete param.tags[key];
    }
  }

  hasTag(name: string, tagKey: string): boolean {
    const param = this.params.get(name);
    return param ? Object.prototype.hasOwnProperty.call(param.tags, tagKey) : false;
  }

  getTags(name: string): Array<{ Key: string; Value: string }> {
    const param = this.params.get(name);
    if (!param) return [];
    return Object.entries(param.tags).map(([Key, Value]) => ({ Key, Value }));
  }

  describeParameters(filters?: Array<{ Key: string; Values: string[] }>): SsmParameter[] {
    let params = Array.from(this.params.values());
    if (filters) {
      for (const f of filters) {
        if (f.Key === "Name") {
          params = params.filter((p) => f.Values.some((v) => p.name === v || p.name.startsWith(v)));
        }
      }
    }
    return params;
  }

  emitPutParameterEvent(paramName: string): void {
    if (!this.eventBridgeStore) return;
    try {
      this.eventBridgeStore.putEventsInternal(this.eventBridgeBusName, [
        {
          source: "aws.ssm",
          "detail-type": "Parameter Store Change",
          detail: { name: paramName, operation: "Create" },
        },
      ]);
    } catch {
      // ignore if bus does not exist
    }
  }

  emitDeleteParameterEvent(paramName: string): void {
    if (!this.eventBridgeStore) return;
    try {
      this.eventBridgeStore.putEventsInternal(this.eventBridgeBusName, [
        {
          source: "aws.ssm",
          "detail-type": "Parameter Store Change",
          detail: { name: paramName, operation: "Delete" },
        },
      ]);
    } catch {
      // ignore if bus does not exist
    }
  }
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}

const TARGET_PREFIX = "AmazonSSM.";

export function registerSsm(app: FastifyInstance, state: ServerState): SsmStore {
  const store = new SsmStore();
  state.resetCallbacks.push(() => store.reset());

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    const operation = target.startsWith(TARGET_PREFIX)
      ? target.slice(TARGET_PREFIX.length)
      : target;
    const body = req.body as Record<string, unknown>;
    const ctx = createRequestContext("ssm", operation);

    if (await applyIamAuth(state, "ssm", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "ssm", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "ssm", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    try {
      handleSsmOp(operation, body, store, state, reply);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      jsonReply(reply, { __type: "ParameterNotFound", message: msg }, 400);
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  return store;
}

function isInCreateDwell(param: SsmParameter, state: ServerState): boolean {
  const rule = state.lifecycleRules.get("ssm");
  if (!rule || !rule.enabled || rule.createDwellMs <= 0) return false;
  return Date.now() - param.createdAt < rule.createDwellMs;
}

function handleSsmOp(
  operation: string,
  body: Record<string, unknown>,
  store: SsmStore,
  state: ServerState,
  reply: FastifyReply,
): void {
  switch (operation) {
    case "PutParameter": {
      const overwrite = body.Overwrite as boolean | undefined;
      const putParamName = body.Name as string;
      const existing = store.getParameter(putParamName);
      if (!existing && overwrite === true) {
        jsonReply(reply, { __type: "ParameterNotFound", message: "Parameter not found." }, 400);
        return;
      }
      if (!existing && overwrite === false) {
        jsonReply(reply, { __type: "ParameterNotFound", message: "Parameter not found." }, 400);
        return;
      }
      if (existing && overwrite !== true) {
        jsonReply(
          reply,
          {
            __type: "ParameterAlreadyExists",
            message: `Parameter ${putParamName} already exists`,
          },
          400,
        );
        return;
      }
      if (existing && isInCreateDwell(existing, state)) {
        jsonReply(reply, { __type: "ParameterNotFound", message: "Parameter not found." }, 400);
        return;
      }
      const param = store.putParameter(
        putParamName,
        body.Value as string,
        (body.Type as string) ?? "String",
        body.Description as string | undefined,
      );
      jsonReply(reply, { Version: param.version, Tier: "Standard" });
      store.emitPutParameterEvent(putParamName);
      break;
    }

    case "GetParameter": {
      const param = store.getParameter(body.Name as string, body.WithDecryption as boolean);
      if (!param || isInCreateDwell(param, state)) {
        reply
          .status(400)
          .send({ __type: "ParameterNotFound", message: `Parameter ${body.Name} not found` });
        return;
      }
      jsonReply(reply, {
        Parameter: {
          Name: param.name,
          Value: param.value,
          Type: param.type,
          Version: param.version,
          ARN: param.arn,
          LastModifiedDate: param.lastModifiedDate,
        },
      });
      break;
    }

    case "GetParameters": {
      const names = (body.Names as string[]) ?? [];
      const params = names.map((n) => store.getParameter(n)).filter(Boolean) as SsmParameter[];
      const invalid = names.filter((n) => !store.getParameter(n));
      jsonReply(reply, {
        Parameters: params.map((p) => ({
          Name: p.name,
          Value: p.value,
          Type: p.type,
          Version: p.version,
          ARN: p.arn,
        })),
        InvalidParameters: invalid,
      });
      break;
    }

    case "GetParametersByPath": {
      const params = store.getParametersByPath(body.Path as string);
      jsonReply(reply, {
        Parameters: params.map((p) => ({
          Name: p.name,
          Value: p.value,
          Type: p.type,
          Version: p.version,
          ARN: p.arn,
        })),
      });
      break;
    }

    case "DeleteParameter": {
      const deleteParamName = body.Name as string;
      const paramToDelete = store.getParameter(deleteParamName);
      if (!paramToDelete || isInCreateDwell(paramToDelete, state)) {
        jsonReply(reply, { __type: "ParameterNotFound", message: "Parameter not found." }, 400);
        return;
      }
      store.deleteParameter(deleteParamName);
      jsonReply(reply, {});
      store.emitDeleteParameterEvent(deleteParamName);
      break;
    }

    case "DeleteParameters": {
      const names = (body.Names as string[]) ?? [];
      const existing = names
        .map((n) => store.getParameter(n))
        .filter((p): p is SsmParameter => !!p && !isInCreateDwell(p, state))
        .map((p) => p.name);
      const missing = names.filter((n) => !existing.includes(n));
      if (existing.length === 0) {
        jsonReply(reply, { __type: "ParameterNotFound", message: "Parameter not found." }, 400);
        return;
      }
      for (const name of existing) store.deleteParameter(name);
      jsonReply(reply, { DeletedParameters: existing, InvalidParameters: missing });
      break;
    }

    case "DescribeParameters": {
      const params = store.describeParameters(
        body.ParameterFilters as Array<{ Key: string; Values: string[] }> | undefined,
      );
      jsonReply(reply, {
        Parameters: params.map((p) => ({
          Name: p.name,
          Type: p.type,
          Version: p.version,
          Description: p.description,
          LastModifiedDate: p.lastModifiedDate,
        })),
      });
      break;
    }

    case "AddTagsToResource": {
      const resourceId = body.ResourceId as string;
      const tagResourceParam = store.getParameter(resourceId);
      if (!tagResourceParam || isInCreateDwell(tagResourceParam, state)) {
        jsonReply(
          reply,
          { __type: "InvalidResourceId", message: "The resource ID you provided does not exist." },
          400,
        );
        return;
      }
      const tagsToAdd = (body.Tags as Array<{ Key: string; Value: string }>) ?? [];
      store.addTags(resourceId, tagsToAdd);
      jsonReply(reply, {});
      break;
    }

    case "RemoveTagsFromResource": {
      const resourceId = body.ResourceId as string;
      if (!store.getParameter(resourceId)) {
        jsonReply(
          reply,
          { __type: "InvalidResourceId", message: "The resource ID you provided does not exist." },
          400,
        );
        return;
      }
      const tagKeys = (body.TagKeys as string[]) ?? [];
      for (const key of tagKeys) {
        if (!store.hasTag(resourceId, key)) {
          jsonReply(
            reply,
            {
              __type: "InvalidResourceId",
              message: "The resource ID you provided does not exist.",
            },
            400,
          );
          return;
        }
      }
      store.removeTags(resourceId, tagKeys);
      jsonReply(reply, {});
      break;
    }

    case "ListTagsForResource": {
      const resourceId = body.ResourceId as string;
      const listTagParam = store.getParameter(resourceId);
      if (!listTagParam || isInCreateDwell(listTagParam, state)) {
        jsonReply(
          reply,
          { __type: "InvalidResourceId", message: "The resource ID you provided does not exist." },
          400,
        );
        return;
      }
      jsonReply(reply, { TagList: store.getTags(resourceId) });
      break;
    }

    default: {
      reply.status(400).send({
        __type: "UnknownOperationException",
        message: `lws: SSM operation '${operation}' is not yet implemented`,
      });
    }
  }
}

void uuidv4;
