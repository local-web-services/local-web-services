"use strict";
/** DynamoDB wire-protocol Fastify plugin. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.registerDynamoDb = registerDynamoDb;
const store_1 = require("./store");
const chaos_1 = require("../../middleware/chaos");
const fake_1 = require("../../middleware/fake");
const iam_1 = require("../../middleware/iam");
const logging_1 = require("../../middleware/logging");
const TARGET_PREFIX = "DynamoDB_20120810.";
function jsonReply(reply, data, status = 200) {
    reply
        .status(status)
        .header("Content-Type", "application/x-amz-json-1.0")
        .send(data);
}
function errorReply(reply, code, message, status = 400) {
    jsonReply(reply, { __type: code, message }, status);
}
function registerDynamoDb(app, state) {
    const store = new store_1.DynamoStore();
    state.resetCallbacks.push(() => store.reset());
    app.post("/", async (req, reply) => {
        const target = req.headers["x-amz-target"] ?? "";
        if (!target.startsWith(TARGET_PREFIX)) {
            return errorReply(reply, "ValidationException", `Unknown target: ${target}`);
        }
        const operation = target.slice(TARGET_PREFIX.length);
        const body = req.body;
        const ctx = (0, logging_1.createRequestContext)("dynamodb", operation);
        // Middleware pipeline
        if (await (0, iam_1.applyIamAuth)(state, "dynamodb", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, chaos_1.applyChaos)(state, "dynamodb", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "dynamodb", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        let responseStatus = 200;
        try {
            await handleDynamoOperation(operation, body, store, reply);
        }
        catch (err) {
            const msg = err instanceof Error ? err.message : String(err);
            if (msg.includes("ResourceNotFoundException")) {
                responseStatus = 400;
                errorReply(reply, "ResourceNotFoundException", msg);
            }
            else {
                responseStatus = 400;
                errorReply(reply, "ValidationException", msg);
            }
        }
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode || responseStatus);
    });
    return store;
}
async function handleDynamoOperation(operation, body, store, reply) {
    switch (operation) {
        case "GetItem": {
            const item = store.getItem(body.TableName, body.Key);
            jsonReply(reply, item ? { Item: item } : {});
            break;
        }
        case "PutItem": {
            store.putItem(body.TableName, body.Item);
            jsonReply(reply, {});
            break;
        }
        case "DeleteItem": {
            store.deleteItem(body.TableName, body.Key);
            jsonReply(reply, {});
            break;
        }
        case "UpdateItem": {
            const updated = store.updateItem(body.TableName, body.Key, body.UpdateExpression ?? "", body.ExpressionAttributeNames, body.ExpressionAttributeValues);
            jsonReply(reply, { Attributes: updated });
            break;
        }
        case "Query": {
            const { items, lastEvaluatedKey } = store.query(body.TableName, body.KeyConditionExpression ?? "", body.ExpressionAttributeNames, body.ExpressionAttributeValues, body.IndexName, body.FilterExpression, body.ScanIndexForward !== false, body.Limit, body.ExclusiveStartKey);
            const result = { Items: items, Count: items.length };
            if (lastEvaluatedKey)
                result.LastEvaluatedKey = lastEvaluatedKey;
            jsonReply(reply, result);
            break;
        }
        case "Scan": {
            const { items, lastEvaluatedKey } = store.scan(body.TableName, body.FilterExpression, body.ExpressionAttributeNames, body.ExpressionAttributeValues, body.Limit, body.ExclusiveStartKey);
            const result = { Items: items, Count: items.length };
            if (lastEvaluatedKey)
                result.LastEvaluatedKey = lastEvaluatedKey;
            jsonReply(reply, result);
            break;
        }
        case "BatchGetItem": {
            const requestItems = (body.RequestItems ?? {});
            const responses = {};
            for (const [tableName, tableReq] of Object.entries(requestItems)) {
                const keys = (tableReq.Keys ?? []);
                responses[tableName] = store.batchGetItems(tableName, keys);
            }
            jsonReply(reply, { Responses: responses });
            break;
        }
        case "BatchWriteItem": {
            const requestItems = (body.RequestItems ?? {});
            for (const [tableName, requests] of Object.entries(requestItems)) {
                const putItems = [];
                const deleteKeys = [];
                for (const req of requests) {
                    if ("PutRequest" in req)
                        putItems.push(req.PutRequest.Item);
                    else if ("DeleteRequest" in req)
                        deleteKeys.push(req.DeleteRequest.Key);
                }
                store.batchWriteItems(tableName, putItems, deleteKeys);
            }
            jsonReply(reply, {});
            break;
        }
        case "CreateTable": {
            const config = parseTableConfig(body);
            const description = store.createTable(config);
            jsonReply(reply, { TableDescription: description });
            break;
        }
        case "DeleteTable": {
            const desc = store.deleteTable(body.TableName);
            jsonReply(reply, { TableDescription: desc });
            break;
        }
        case "DescribeTable": {
            const desc = store.describeTable(body.TableName);
            jsonReply(reply, desc);
            break;
        }
        case "ListTables": {
            jsonReply(reply, { TableNames: store.listTables() });
            break;
        }
        case "UpdateTable": {
            const desc = store.describeTable(body.TableName);
            jsonReply(reply, { TableDescription: desc.Table });
            break;
        }
        case "TransactWriteItems": {
            const items = (body.TransactItems ?? []);
            // First pass: evaluate all condition checks
            const cancellationReasons = [];
            let transactionCancelled = false;
            for (const txItem of items) {
                if ("ConditionCheck" in txItem) {
                    const cc = txItem.ConditionCheck;
                    const condExpr = cc.ConditionExpression;
                    if (condExpr) {
                        const existingItem = store.getItem(cc.TableName, cc.Key);
                        const exprNames = cc.ExpressionAttributeNames ?? {};
                        const exprValues = cc.ExpressionAttributeValues ?? {};
                        const conditionMet = (0, store_1.evaluateFilter)(existingItem ?? {}, condExpr, exprNames, exprValues);
                        if (!conditionMet) {
                            transactionCancelled = true;
                            cancellationReasons.push({ Code: "ConditionalCheckFailed" });
                        }
                        else {
                            cancellationReasons.push({});
                        }
                    }
                    else {
                        cancellationReasons.push({});
                    }
                }
                else {
                    cancellationReasons.push({});
                }
            }
            if (transactionCancelled) {
                jsonReply(reply, {
                    __type: "TransactionCanceledException",
                    message: "Transaction cancelled, please refer cancellationReasons for specific reasons [ConditionalCheckFailed]",
                    CancellationReasons: cancellationReasons,
                }, 400);
                break;
            }
            // Second pass: apply writes
            for (const txItem of items) {
                if ("Put" in txItem) {
                    const put = txItem.Put;
                    store.putItem(put.TableName, put.Item);
                }
                else if ("Delete" in txItem) {
                    const del = txItem.Delete;
                    store.deleteItem(del.TableName, del.Key);
                }
                else if ("Update" in txItem) {
                    const upd = txItem.Update;
                    store.updateItem(upd.TableName, upd.Key, upd.UpdateExpression ?? "", upd.ExpressionAttributeNames, upd.ExpressionAttributeValues);
                }
            }
            jsonReply(reply, {});
            break;
        }
        case "TransactGetItems": {
            const items = (body.TransactItems ?? []);
            const responses = items.map((txItem) => {
                const get = txItem.Get;
                const item = store.getItem(get.TableName, get.Key);
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
            const spec = (body.TimeToLiveSpecification ?? {});
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
                .send({ __type: "UnknownOperationException", message: `lws: DynamoDB operation '${operation}' is not yet implemented` });
        }
    }
}
function parseTableConfig(body) {
    const tableName = body.TableName;
    const attrTypes = {};
    for (const ad of (body.AttributeDefinitions ?? [])) {
        attrTypes[ad.AttributeName] = ad.AttributeType ?? "S";
    }
    let pk = { name: "pk", type: "S" };
    let sk;
    for (const ks of (body.KeySchema ?? [])) {
        const attr = { name: ks.AttributeName, type: attrTypes[ks.AttributeName] ?? "S" };
        if (ks.KeyType === "HASH")
            pk = attr;
        else
            sk = attr;
    }
    const gsis = [];
    for (const gsiRaw of (body.GlobalSecondaryIndexes ?? [])) {
        let gsiPk = { name: "pk", type: "S" };
        let gsiSk;
        for (const ks of (gsiRaw.KeySchema ?? [])) {
            const attr = { name: ks.AttributeName, type: attrTypes[ks.AttributeName] ?? "S" };
            if (ks.KeyType === "HASH")
                gsiPk = attr;
            else
                gsiSk = attr;
        }
        const proj = (gsiRaw.Projection ?? {});
        gsis.push({
            name: gsiRaw.IndexName,
            pk: gsiPk,
            sk: gsiSk,
            projectionType: proj.ProjectionType ?? "ALL",
        });
    }
    return { name: tableName, pk, sk, gsis };
}
//# sourceMappingURL=index.js.map