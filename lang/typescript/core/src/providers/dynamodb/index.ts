/** DynamoDB wire-protocol Fastify plugin. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { DynamoStore, type TableConfig, type KeyAttr, type GsiDef, evaluateFilter } from "./store";
import type { ServerState } from "../../types";
import { isExhausted } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const TARGET_PREFIX = "DynamoDB_20120810.";

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/x-amz-json-1.0").send(data);
}

function errorReply(reply: FastifyReply, code: string, message: string, status = 400): void {
  jsonReply(reply, { __type: code, message }, status);
}

export function registerDynamoDb(app: FastifyInstance, state: ServerState): DynamoStore {
  const store = new DynamoStore();

  state.resetCallbacks.push(() => store.reset());
  // Register ARN existence checker for DynamoDB tables
  // DynamoDB table ARN format: arn:aws:dynamodb:region:account:table/tableName
  state.arnExistsCheckers.set("dynamodb", (arn: string) => {
    const match = arn.match(/\/([^/]+)$/);
    const tableName = match ? match[1] : arn;
    return store.tableExists(tableName);
  });

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    if (!target.startsWith(TARGET_PREFIX)) {
      return errorReply(reply, "ValidationException", `Unknown target: ${target}`);
    }
    const operation = target.slice(TARGET_PREFIX.length);
    const body = req.body as Record<string, unknown>;

    const ctx = createRequestContext("dynamodb", operation);

    // Middleware pipeline
    if (await applyIamAuth(state, "dynamodb", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "dynamodb", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "dynamodb", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    if (
      operation === "PutItem" &&
      isExhausted(state.capacityConfigs["dynamodb"] ?? { slots: null })
    ) {
      errorReply(reply, "ProvisionedThroughputExceededException", "No write capacity available");
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    let responseStatus = 200;

    try {
      await handleDynamoOperation(operation, body, store, reply);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.includes("ResourceNotFoundException")) {
        responseStatus = 400;
        errorReply(reply, "ResourceNotFoundException", msg);
      } else {
        responseStatus = 400;
        errorReply(reply, "ValidationException", msg);
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode || responseStatus);
  });

  return store;
}

async function handleDynamoOperation(
  operation: string,
  body: Record<string, unknown>,
  store: DynamoStore,
  reply: FastifyReply,
): Promise<void> {
  switch (operation) {
    case "GetItem": {
      const item = store.getItem(body.TableName as string, body.Key as Record<string, unknown>);
      jsonReply(reply, item ? { Item: item } : {});
      break;
    }

    case "PutItem": {
      store.putItem(body.TableName as string, body.Item as Record<string, unknown>);
      jsonReply(reply, {});
      break;
    }

    case "DeleteItem": {
      const tableName = body.TableName as string;
      const key = body.Key as Record<string, unknown>;
      const existingForDelete = store.getItem(tableName, key);
      if (!existingForDelete) {
        errorReply(
          reply,
          "com.amazonaws.dynamodb.v20120810#ConditionalCheckFailedException",
          "The conditional request failed",
        );
        break;
      }
      store.deleteItem(tableName, key);
      jsonReply(reply, {});
      break;
    }

    case "UpdateItem": {
      const tableName = body.TableName as string;
      const key = body.Key as Record<string, unknown>;
      const existingForUpdate = store.getItem(tableName, key);
      if (!existingForUpdate) {
        errorReply(
          reply,
          "com.amazonaws.dynamodb.v20120810#ConditionalCheckFailedException",
          "The conditional request failed",
        );
        break;
      }
      const updated = store.updateItem(
        tableName,
        key,
        (body.UpdateExpression as string) ?? "",
        body.ExpressionAttributeNames as Record<string, string> | undefined,
        body.ExpressionAttributeValues as Record<string, Record<string, unknown>> | undefined,
      );
      jsonReply(reply, { Attributes: updated });
      break;
    }

    case "Query": {
      const { items, lastEvaluatedKey } = store.query(
        body.TableName as string,
        (body.KeyConditionExpression as string) ?? "",
        body.ExpressionAttributeNames as Record<string, string> | undefined,
        body.ExpressionAttributeValues as Record<string, Record<string, unknown>> | undefined,
        body.IndexName as string | undefined,
        body.FilterExpression as string | undefined,
        body.ScanIndexForward !== false,
        body.Limit as number | undefined,
        body.ExclusiveStartKey as Record<string, unknown> | undefined,
      );
      const result: Record<string, unknown> = { Items: items, Count: items.length };
      if (lastEvaluatedKey) result.LastEvaluatedKey = lastEvaluatedKey;
      jsonReply(reply, result);
      break;
    }

    case "Scan": {
      const { items, lastEvaluatedKey } = store.scan(
        body.TableName as string,
        body.FilterExpression as string | undefined,
        body.ExpressionAttributeNames as Record<string, string> | undefined,
        body.ExpressionAttributeValues as Record<string, Record<string, unknown>> | undefined,
        body.Limit as number | undefined,
        body.ExclusiveStartKey as Record<string, unknown> | undefined,
      );
      const result: Record<string, unknown> = { Items: items, Count: items.length };
      if (lastEvaluatedKey) result.LastEvaluatedKey = lastEvaluatedKey;
      jsonReply(reply, result);
      break;
    }

    case "BatchGetItem": {
      const requestItems = (body.RequestItems ?? {}) as Record<string, Record<string, unknown>>;
      const responses: Record<string, Array<Record<string, unknown>>> = {};
      for (const [tableName, tableReq] of Object.entries(requestItems)) {
        const keys = (tableReq.Keys ?? []) as Array<Record<string, unknown>>;
        responses[tableName] = store.batchGetItems(tableName, keys);
      }
      jsonReply(reply, { Responses: responses });
      break;
    }

    case "BatchWriteItem": {
      const requestItems = (body.RequestItems ?? {}) as Record<
        string,
        Array<Record<string, unknown>>
      >;
      for (const [tableName, requests] of Object.entries(requestItems)) {
        const putItems: Array<Record<string, unknown>> = [];
        const deleteKeys: Array<Record<string, unknown>> = [];
        for (const req of requests) {
          if ("PutRequest" in req)
            putItems.push(
              (req.PutRequest as Record<string, unknown>).Item as Record<string, unknown>,
            );
          else if ("DeleteRequest" in req)
            deleteKeys.push(
              (req.DeleteRequest as Record<string, unknown>).Key as Record<string, unknown>,
            );
        }
        store.batchWriteItems(tableName, putItems, deleteKeys);
      }
      jsonReply(reply, {});
      break;
    }

    case "CreateTable": {
      const tableName = body.TableName as string;
      if (store.tableExists(tableName)) {
        errorReply(
          reply,
          "com.amazonaws.dynamodb.v20120810#ResourceInUseException",
          `Table already exists: ${tableName}`,
        );
        break;
      }
      const config = parseTableConfig(body);
      const description = store.createTable(config);
      jsonReply(reply, { TableDescription: description });
      break;
    }

    case "DeleteTable": {
      const desc = store.deleteTable(body.TableName as string);
      jsonReply(reply, { TableDescription: desc });
      break;
    }

    case "DescribeTable": {
      const desc = store.describeTable(body.TableName as string);
      jsonReply(reply, desc);
      break;
    }

    case "ListTables": {
      jsonReply(reply, { TableNames: store.listTables() });
      break;
    }

    case "UpdateTable": {
      const desc = store.describeTable(body.TableName as string);
      jsonReply(reply, { TableDescription: (desc as Record<string, unknown>).Table });
      break;
    }

    case "TransactWriteItems": {
      const items = (body.TransactItems ?? []) as Array<Record<string, unknown>>;
      // First pass: evaluate all condition checks
      const cancellationReasons: Array<{ Code?: string }> = [];
      let transactionCancelled = false;
      for (const txItem of items) {
        if ("ConditionCheck" in txItem) {
          const cc = txItem.ConditionCheck as Record<string, unknown>;
          const condExpr = cc.ConditionExpression as string | undefined;
          if (condExpr) {
            const existingItem = store.getItem(
              cc.TableName as string,
              cc.Key as Record<string, unknown>,
            );
            const exprNames = (cc.ExpressionAttributeNames as Record<string, string>) ?? {};
            const exprValues =
              (cc.ExpressionAttributeValues as Record<string, Record<string, unknown>>) ?? {};
            const conditionMet = evaluateFilter(
              existingItem ?? {},
              condExpr,
              exprNames,
              exprValues,
            );
            if (!conditionMet) {
              transactionCancelled = true;
              cancellationReasons.push({ Code: "ConditionalCheckFailed" });
            } else {
              cancellationReasons.push({});
            }
          } else {
            cancellationReasons.push({});
          }
        } else {
          cancellationReasons.push({});
        }
      }
      if (transactionCancelled) {
        jsonReply(
          reply,
          {
            __type: "TransactionCanceledException",
            message:
              "Transaction cancelled, please refer cancellationReasons for specific reasons [ConditionalCheckFailed]",
            CancellationReasons: cancellationReasons,
          },
          400,
        );
        break;
      }
      // Second pass: apply writes
      for (const txItem of items) {
        if ("Put" in txItem) {
          const put = txItem.Put as Record<string, unknown>;
          store.putItem(put.TableName as string, put.Item as Record<string, unknown>);
        } else if ("Delete" in txItem) {
          const del = txItem.Delete as Record<string, unknown>;
          store.deleteItem(del.TableName as string, del.Key as Record<string, unknown>);
        } else if ("Update" in txItem) {
          const upd = txItem.Update as Record<string, unknown>;
          store.updateItem(
            upd.TableName as string,
            upd.Key as Record<string, unknown>,
            (upd.UpdateExpression as string) ?? "",
            upd.ExpressionAttributeNames as Record<string, string> | undefined,
            upd.ExpressionAttributeValues as Record<string, Record<string, unknown>> | undefined,
          );
        }
      }
      jsonReply(reply, {});
      break;
    }

    case "TransactGetItems": {
      const items = (body.TransactItems ?? []) as Array<Record<string, unknown>>;
      const responses = items.map((txItem) => {
        const get = txItem.Get as Record<string, unknown>;
        const item = store.getItem(get.TableName as string, get.Key as Record<string, unknown>);
        return item ? { Item: item } : {};
      });
      jsonReply(reply, { Responses: responses });
      break;
    }

    case "DescribeTimeToLive": {
      jsonReply(reply, {
        TimeToLiveDescription: {
          TimeToLiveStatus: "DISABLED",
          TableName: body.TableName,
        },
      });
      break;
    }

    case "UpdateTimeToLive": {
      const spec = (body.TimeToLiveSpecification ?? {}) as Record<string, unknown>;
      jsonReply(reply, { TimeToLiveSpecification: spec });
      break;
    }

    case "DescribeContinuousBackups": {
      jsonReply(reply, {
        ContinuousBackupsDescription: {
          ContinuousBackupsStatus: "DISABLED",
          PointInTimeRecoveryDescription: { PointInTimeRecoveryStatus: "DISABLED" },
        },
      });
      break;
    }

    case "ListTagsOfResource": {
      jsonReply(reply, { Tags: [] });
      break;
    }

    case "TagResource":
    case "UntagResource": {
      jsonReply(reply, {});
      break;
    }

    default: {
      reply
        .status(400)
        .header("Content-Type", "application/x-amz-json-1.0")
        .send({
          __type: "UnknownOperationException",
          message: `lws: DynamoDB operation '${operation}' is not yet implemented`,
        });
    }
  }
}

function parseTableConfig(body: Record<string, unknown>): TableConfig {
  const tableName = body.TableName as string;
  const attrTypes: Record<string, string> = {};
  for (const ad of (body.AttributeDefinitions ?? []) as Array<Record<string, string>>) {
    attrTypes[ad.AttributeName] = ad.AttributeType ?? "S";
  }

  let pk: KeyAttr = { name: "pk", type: "S" };
  let sk: KeyAttr | undefined;

  for (const ks of (body.KeySchema ?? []) as Array<Record<string, string>>) {
    const attr: KeyAttr = { name: ks.AttributeName, type: attrTypes[ks.AttributeName] ?? "S" };
    if (ks.KeyType === "HASH") pk = attr;
    else sk = attr;
  }

  const gsis: GsiDef[] = [];
  for (const gsiRaw of (body.GlobalSecondaryIndexes ?? []) as Array<Record<string, unknown>>) {
    let gsiPk: KeyAttr = { name: "pk", type: "S" };
    let gsiSk: KeyAttr | undefined;
    for (const ks of (gsiRaw.KeySchema ?? []) as Array<Record<string, string>>) {
      const attr: KeyAttr = { name: ks.AttributeName, type: attrTypes[ks.AttributeName] ?? "S" };
      if (ks.KeyType === "HASH") gsiPk = attr;
      else gsiSk = attr;
    }
    const proj = (gsiRaw.Projection ?? {}) as Record<string, string>;
    gsis.push({
      name: gsiRaw.IndexName as string,
      pk: gsiPk,
      sk: gsiSk,
      projectionType: proj.ProjectionType ?? "ALL",
    });
  }

  return { name: tableName, pk, sk, gsis };
}
