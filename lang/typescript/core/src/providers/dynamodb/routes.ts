/**
 * DynamoDB wire-protocol Fastify plugin.
 *
 * Handles AWS JSON 1.0 protocol via X-Amz-Target: DynamoDB_20120810.<Operation>
 *
 * Mirrors `providers/dynamodb/routes.py`.
 */

import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { DynamoAttributeValue, DynamoItem } from "./table.js";
import type { DynamoProvider } from "./provider.js";
import type { ExpressionContext } from "./expressions.js";

export interface DynamoRoutesOptions {
  provider: DynamoProvider;
}

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

function buildCtx(body: Record<string, unknown>): ExpressionContext {
  const ctx: ExpressionContext = {};
  if (body["ExpressionAttributeNames"] !== undefined) {
    ctx.expressionAttributeNames = body["ExpressionAttributeNames"] as Record<string, string>;
  }
  if (body["ExpressionAttributeValues"] !== undefined) {
    ctx.expressionAttributeValues = body["ExpressionAttributeValues"] as Record<string, DynamoAttributeValue>;
  }
  return ctx;
}

export async function dynamoRoutesPlugin(
  fastify: FastifyInstance,
  opts: DynamoRoutesOptions,
): Promise<void> {
  const { provider } = opts;

  fastify.addContentTypeParser(
    "application/x-amz-json-1.0",
    { parseAs: "string" },
    (_req, body, done) => {
      try {
        done(null, JSON.parse(body as string));
      } catch (err) {
        done(err as Error);
      }
    },
  );

  fastify.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string | undefined) ?? "";
    const prefix = "DynamoDB_20120810.";
    if (!target.startsWith(prefix)) {
      return reply
        .status(400)
        .header("content-type", "application/x-amz-json-1.0")
        .send(jsonError("InvalidAction", `Unknown target: ${target}`));
    }

    const action = target.slice(prefix.length);
    const body = req.body as Record<string, unknown>;

    reply.header("content-type", "application/x-amz-json-1.0");

    try {
      switch (action) {
        case "CreateTable": {
          const tableName = body["TableName"] as string;
          const keySchema = (body["KeySchema"] as Array<{ AttributeName: string; KeyType: string }>) ?? [];
          const attrDefs = (body["AttributeDefinitions"] as Array<{ AttributeName: string; AttributeType: string }>) ?? [];
          const attrMap = new Map(attrDefs.map((a) => [a.AttributeName, a.AttributeType]));
          const hashDef = keySchema.find((k) => k.KeyType === "HASH");
          const sortDef = keySchema.find((k) => k.KeyType === "RANGE");
          const table = provider.createTable({
            tableName,
            hashKey: hashDef?.AttributeName ?? "pk",
            hashKeyType: hashDef !== undefined ? (attrMap.get(hashDef.AttributeName) ?? "S") : "S",
            sortKey: sortDef?.AttributeName,
            sortKeyType: sortDef !== undefined ? (attrMap.get(sortDef.AttributeName) ?? "S") : "S",
          });
          void table;
          return reply.status(200).send(JSON.stringify({ TableDescription: provider.describeTable(tableName) }));
        }

        case "DeleteTable": {
          const tableName = body["TableName"] as string;
          provider.deleteTable(tableName);
          return reply.status(200).send(JSON.stringify({ TableDescription: { TableName: tableName, TableStatus: "DELETING" } }));
        }

        case "DescribeTable": {
          const tableName = body["TableName"] as string;
          const desc = provider.describeTable(tableName);
          return reply.status(200).send(JSON.stringify({ Table: desc }));
        }

        case "ListTables": {
          return reply.status(200).send(JSON.stringify({ TableNames: provider.listTables() }));
        }

        case "PutItem": {
          const tableName = body["TableName"] as string;
          const item = body["Item"] as DynamoItem;
          provider.putItem(tableName, item);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "GetItem": {
          const tableName = body["TableName"] as string;
          const key = body["Key"] as DynamoItem;
          const item = provider.getItem(tableName, key);
          if (item === undefined) {
            return reply.status(200).send(JSON.stringify({}));
          }
          return reply.status(200).send(JSON.stringify({ Item: item }));
        }

        case "DeleteItem": {
          const tableName = body["TableName"] as string;
          const key = body["Key"] as DynamoItem;
          const deleted = provider.deleteItem(tableName, key);
          if (deleted !== undefined) {
            return reply.status(200).send(JSON.stringify({ Attributes: deleted }));
          }
          return reply.status(200).send(JSON.stringify({}));
        }

        case "UpdateItem": {
          const tableName = body["TableName"] as string;
          const key = body["Key"] as DynamoItem;
          const updateExpression = body["UpdateExpression"] as string;
          const ctx = buildCtx(body);
          const updated = provider.updateItem(tableName, key, updateExpression, ctx);
          return reply.status(200).send(JSON.stringify({ Attributes: updated }));
        }

        case "Scan": {
          const tableName = body["TableName"] as string;
          const filterExpression = body["FilterExpression"] as string | undefined;
          const ctx = buildCtx(body);
          const items = provider.scan(tableName, filterExpression, ctx);
          return reply.status(200).send(JSON.stringify({ Items: items, Count: items.length, ScannedCount: items.length }));
        }

        case "Query": {
          const tableName = body["TableName"] as string;
          const keyConditionExpression = body["KeyConditionExpression"] as string;
          const filterExpression = body["FilterExpression"] as string | undefined;
          const ctx = buildCtx(body);
          const items = provider.query(tableName, keyConditionExpression, ctx, filterExpression);
          return reply.status(200).send(JSON.stringify({ Items: items, Count: items.length, ScannedCount: items.length }));
        }

        case "BatchGetItem": {
          const requestItems = body["RequestItems"] as Record<string, { Keys: DynamoItem[] }>;
          const responses = provider.batchGetItem(requestItems);
          return reply.status(200).send(JSON.stringify({ Responses: responses, UnprocessedKeys: {} }));
        }

        case "BatchWriteItem": {
          type WriteOp = { PutRequest?: { Item: DynamoItem }; DeleteRequest?: { Key: DynamoItem } };
          const requestItems = body["RequestItems"] as Record<string, WriteOp[]>;
          provider.batchWriteItem(requestItems);
          return reply.status(200).send(JSON.stringify({ UnprocessedItems: {} }));
        }

        case "TransactGetItems": {
          type TransactGet = { Get: { TableName: string; Key: DynamoItem } };
          const transactItems = body["TransactItems"] as TransactGet[];
          const responses = provider.transactGetItems(transactItems);
          return reply.status(200).send(JSON.stringify({ Responses: responses }));
        }

        case "TransactWriteItems": {
          type TransactWrite = { Put?: { TableName: string; Item: DynamoItem }; Delete?: { TableName: string; Key: DynamoItem }; Update?: { TableName: string; Key: DynamoItem; UpdateExpression: string } & Record<string, unknown> };
          const transactItems = body["TransactItems"] as TransactWrite[];
          provider.transactWriteItems(transactItems);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "UpdateTable": {
          const tableName = body["TableName"] as string;
          return reply.status(200).send(JSON.stringify(provider.updateTable(tableName)));
        }

        case "DescribeContinuousBackups": {
          const tableName = body["TableName"] as string;
          return reply.status(200).send(JSON.stringify(provider.describeContinuousBackups(tableName)));
        }

        case "DescribeTimeToLive": {
          const tableName = body["TableName"] as string;
          return reply.status(200).send(JSON.stringify(provider.describeTimeToLive(tableName)));
        }

        case "UpdateTimeToLive": {
          const tableName = body["TableName"] as string;
          const spec = body["TimeToLiveSpecification"] as { AttributeName: string; Enabled: boolean };
          return reply.status(200).send(JSON.stringify(provider.updateTimeToLive(tableName, { attributeName: spec.AttributeName, enabled: spec.Enabled })));
        }

        case "TagResource": {
          const arn = body["ResourceArn"] as string;
          const tags = body["Tags"] as Array<{ Key: string; Value: string }>;
          provider.tagResource(arn, tags);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "UntagResource": {
          const arn = body["ResourceArn"] as string;
          const tagKeys = body["TagKeys"] as string[];
          provider.untagResource(arn, tagKeys);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "ListTagsOfResource": {
          const arn = body["ResourceArn"] as string;
          const tags = provider.listTagsOfResource(arn);
          return reply.status(200).send(JSON.stringify({ Tags: tags }));
        }

        default:
          return reply
            .status(400)
            .send(jsonError("InvalidAction", `Unsupported action: ${action}`));
      }
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.startsWith("ResourceNotFoundException")) {
        return reply.status(400).send(jsonError("ResourceNotFoundException", msg));
      }
      if (msg.startsWith("ResourceInUseException")) {
        return reply.status(400).send(jsonError("ResourceInUseException", msg));
      }
      if (msg.startsWith("ValidationException")) {
        return reply.status(400).send(jsonError("ValidationException", msg));
      }
      return reply.status(500).send(jsonError("InternalServerError", msg));
    }
  });
}
