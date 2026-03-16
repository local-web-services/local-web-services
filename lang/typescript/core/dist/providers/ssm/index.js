"use strict";
/** SSM wire-protocol Fastify plugin (JSON API). */
Object.defineProperty(exports, "__esModule", { value: true });
exports.SsmStore = void 0;
exports.registerSsm = registerSsm;
const uuid_1 = require("uuid");
const chaos_1 = require("../../middleware/chaos");
const fake_1 = require("../../middleware/fake");
const iam_1 = require("../../middleware/iam");
const logging_1 = require("../../middleware/logging");
const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";
class SsmStore {
    constructor() {
        this.params = new Map();
    }
    reset() {
        this.params.clear();
    }
    putParameter(name, value, type = "String", description) {
        const existing = this.params.get(name);
        const param = {
            name,
            value,
            type,
            version: (existing?.version ?? 0) + 1,
            arn: `arn:aws:ssm:${REGION}:${ACCOUNT_ID}:parameter${name}`,
            description,
            lastModifiedDate: Date.now() / 1000,
        };
        this.params.set(name, param);
        return param;
    }
    getParameter(name, withDecryption) {
        void withDecryption;
        return this.params.get(name);
    }
    getParametersByPath(path) {
        return Array.from(this.params.values()).filter((p) => p.name.startsWith(path));
    }
    deleteParameter(name) {
        this.params.delete(name);
    }
    describeParameters(filters) {
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
}
exports.SsmStore = SsmStore;
function jsonReply(reply, data, status = 200) {
    reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}
const TARGET_PREFIX = "AmazonSSM.";
function registerSsm(app, state) {
    const store = new SsmStore();
    state.resetCallbacks.push(() => store.reset());
    app.post("/", async (req, reply) => {
        const target = req.headers["x-amz-target"] ?? "";
        const operation = target.startsWith(TARGET_PREFIX) ? target.slice(TARGET_PREFIX.length) : target;
        const body = req.body;
        const ctx = (0, logging_1.createRequestContext)("ssm", operation);
        if (await (0, iam_1.applyIamAuth)(state, "ssm", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, chaos_1.applyChaos)(state, "ssm", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "ssm", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        try {
            handleSsmOp(operation, body, store, reply);
        }
        catch (err) {
            const msg = err instanceof Error ? err.message : String(err);
            jsonReply(reply, { __type: "ParameterNotFound", message: msg }, 400);
        }
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    return store;
}
function handleSsmOp(operation, body, store, reply) {
    switch (operation) {
        case "PutParameter": {
            const param = store.putParameter(body.Name, body.Value, body.Type ?? "String", body.Description);
            jsonReply(reply, { Version: param.version, Tier: "Standard" });
            break;
        }
        case "GetParameter": {
            const param = store.getParameter(body.Name, body.WithDecryption);
            if (!param) {
                reply.status(400).send({ __type: "ParameterNotFound", message: `Parameter ${body.Name} not found` });
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
            const names = body.Names ?? [];
            const params = names.map((n) => store.getParameter(n)).filter(Boolean);
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
            const params = store.getParametersByPath(body.Path);
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
            store.deleteParameter(body.Name);
            jsonReply(reply, {});
            break;
        }
        case "DeleteParameters": {
            const names = body.Names ?? [];
            for (const name of names)
                store.deleteParameter(name);
            jsonReply(reply, { DeletedParameters: names, InvalidParameters: [] });
            break;
        }
        case "DescribeParameters": {
            const params = store.describeParameters(body.ParameterFilters);
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
        case "AddTagsToResource":
        case "RemoveTagsFromResource": {
            jsonReply(reply, {});
            break;
        }
        case "ListTagsForResource": {
            jsonReply(reply, { TagList: [] });
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
void uuid_1.v4;
//# sourceMappingURL=index.js.map