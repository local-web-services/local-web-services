"use strict";
/** SecretsManager wire-protocol Fastify plugin. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.SecretsManagerStore = void 0;
exports.registerSecretsManager = registerSecretsManager;
const uuid_1 = require("uuid");
const chaos_1 = require("../../middleware/chaos");
const fake_1 = require("../../middleware/fake");
const iam_1 = require("../../middleware/iam");
const logging_1 = require("../../middleware/logging");
const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";
class SecretsManagerStore {
    constructor() {
        this.secrets = new Map();
    }
    reset() {
        this.secrets.clear();
    }
    createSecret(name, secretString, secretBinary, description) {
        if (this.secrets.has(name))
            throw new Error(`ResourceExistsException: Secret ${name} already exists`);
        const now = Date.now() / 1000;
        const secret = {
            name,
            arn: `arn:aws:secretsmanager:${REGION}:${ACCOUNT_ID}:secret:${name}`,
            secretString,
            secretBinary,
            description,
            versionId: (0, uuid_1.v4)(),
            createdDate: now,
            lastChangedDate: now,
            tags: {},
        };
        this.secrets.set(name, secret);
        return secret;
    }
    getSecret(secretId) {
        const s = this.secrets.get(secretId) ?? Array.from(this.secrets.values()).find((s) => s.arn === secretId);
        // Treat deleted secrets as not found (like real AWS behavior)
        if (s?.deletedDate !== undefined)
            return undefined;
        return s;
    }
    getSecretIncludingDeleted(secretId) {
        return this.secrets.get(secretId) ?? Array.from(this.secrets.values()).find((s) => s.arn === secretId);
    }
    putSecretValue(secretId, secretString, secretBinary) {
        let secret = this.getSecret(secretId);
        if (!secret) {
            // Auto-create if not exists
            secret = this.createSecret(secretId, secretString, secretBinary);
        }
        else {
            secret.secretString = secretString ?? secret.secretString;
            secret.secretBinary = secretBinary ?? secret.secretBinary;
            secret.versionId = (0, uuid_1.v4)();
            secret.lastChangedDate = Date.now() / 1000;
        }
        return secret;
    }
    updateSecret(secretId, secretString, secretBinary, description) {
        const secret = this.getSecret(secretId);
        if (!secret)
            throw new Error(`ResourceNotFoundException: Secret ${secretId} not found`);
        if (secretString !== undefined)
            secret.secretString = secretString;
        if (secretBinary !== undefined)
            secret.secretBinary = secretBinary;
        if (description !== undefined)
            secret.description = description;
        secret.versionId = (0, uuid_1.v4)();
        secret.lastChangedDate = Date.now() / 1000;
        return secret;
    }
    restoreSecret(secretId) {
        const secret = this.getSecretIncludingDeleted(secretId);
        if (!secret)
            throw new Error(`ResourceNotFoundException: Secret ${secretId} not found`);
        delete secret.deletedDate;
        return secret;
    }
    addTags(secretId, tags) {
        const secret = this.getSecret(secretId);
        if (secret) {
            for (const tag of tags)
                secret.tags[tag.Key] = tag.Value;
        }
    }
    removeTags(secretId, tagKeys) {
        const secret = this.getSecret(secretId);
        if (secret) {
            for (const key of tagKeys)
                delete secret.tags[key];
        }
    }
    listSecretVersionIds(secretId) {
        const secret = this.getSecret(secretId);
        if (!secret)
            throw new Error(`ResourceNotFoundException: Secret ${secretId} not found`);
        return [{ VersionId: secret.versionId, VersionStages: ["AWSCURRENT"], CreatedDate: secret.createdDate }];
    }
    deleteSecret(secretId, forceDelete = false) {
        const secret = this.getSecret(secretId);
        if (secret) {
            if (forceDelete) {
                this.secrets.delete(secret.name);
            }
            else {
                secret.deletedDate = Date.now() / 1000;
            }
        }
    }
    listSecrets() {
        return Array.from(this.secrets.values());
    }
}
exports.SecretsManagerStore = SecretsManagerStore;
function jsonReply(reply, data, status = 200) {
    reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}
const TARGET_PREFIX = "secretsmanager.";
function registerSecretsManager(app, state) {
    const store = new SecretsManagerStore();
    state.resetCallbacks.push(() => store.reset());
    app.post("/", async (req, reply) => {
        const target = req.headers["x-amz-target"] ?? "";
        const operation = target.startsWith(TARGET_PREFIX) ? target.slice(TARGET_PREFIX.length) : target;
        const body = req.body;
        const ctx = (0, logging_1.createRequestContext)("secretsmanager", operation);
        if (await (0, iam_1.applyIamAuth)(state, "secretsmanager", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, chaos_1.applyChaos)(state, "secretsmanager", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "secretsmanager", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        try {
            handleOperation(operation, body, store, reply);
        }
        catch (err) {
            const msg = err instanceof Error ? err.message : String(err);
            if (msg.includes("ResourceNotFoundException")) {
                jsonReply(reply, { __type: "ResourceNotFoundException", message: msg }, 400);
            }
            else if (msg.includes("ResourceExistsException")) {
                jsonReply(reply, { __type: "ResourceExistsException", message: msg }, 400);
            }
            else {
                jsonReply(reply, { __type: "InvalidRequestException", message: msg }, 400);
            }
        }
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    return store;
}
function handleOperation(operation, body, store, reply) {
    switch (operation) {
        case "CreateSecret": {
            const secret = store.createSecret(body.Name, body.SecretString, body.SecretBinary, body.Description);
            jsonReply(reply, {
                ARN: secret.arn,
                Name: secret.name,
                VersionId: secret.versionId,
            });
            break;
        }
        case "GetSecretValue": {
            const secret = store.getSecret(body.SecretId);
            if (!secret) {
                jsonReply(reply, { __type: "ResourceNotFoundException", message: `Secret ${body.SecretId} not found` }, 400);
                return;
            }
            const result = {
                ARN: secret.arn,
                Name: secret.name,
                VersionId: secret.versionId,
                CreatedDate: secret.createdDate,
            };
            if (secret.secretString !== undefined)
                result.SecretString = secret.secretString;
            if (secret.secretBinary !== undefined)
                result.SecretBinary = secret.secretBinary;
            jsonReply(reply, result);
            break;
        }
        case "PutSecretValue": {
            const secret = store.putSecretValue(body.SecretId, body.SecretString, body.SecretBinary);
            jsonReply(reply, {
                ARN: secret.arn,
                Name: secret.name,
                VersionId: secret.versionId,
            });
            break;
        }
        case "UpdateSecret": {
            const secret = store.updateSecret(body.SecretId, body.SecretString, body.SecretBinary, body.Description);
            jsonReply(reply, { ARN: secret.arn, Name: secret.name, VersionId: secret.versionId });
            break;
        }
        case "DeleteSecret": {
            const forceDelete = !!(body.ForceDeleteWithoutRecovery);
            store.deleteSecret(body.SecretId, forceDelete);
            jsonReply(reply, {});
            break;
        }
        case "ListSecrets": {
            const secrets = store.listSecrets();
            jsonReply(reply, {
                SecretList: secrets.map((s) => ({
                    ARN: s.arn,
                    Name: s.name,
                    Description: s.description,
                    LastChangedDate: s.lastChangedDate,
                    CreatedDate: s.createdDate,
                })),
            });
            break;
        }
        case "DescribeSecret": {
            const secret = store.getSecret(body.SecretId);
            if (!secret) {
                jsonReply(reply, { __type: "ResourceNotFoundException", message: `Secret ${body.SecretId} not found` }, 400);
                return;
            }
            jsonReply(reply, {
                ARN: secret.arn,
                Name: secret.name,
                Description: secret.description,
                LastChangedDate: secret.lastChangedDate,
                CreatedDate: secret.createdDate,
                Tags: Object.entries(secret.tags).map(([Key, Value]) => ({ Key, Value })),
            });
            break;
        }
        case "TagResource": {
            const tags = body.Tags ?? [];
            store.addTags(body.SecretId, tags);
            jsonReply(reply, {});
            break;
        }
        case "UntagResource": {
            const tagKeys = body.TagKeys ?? [];
            store.removeTags(body.SecretId, tagKeys);
            jsonReply(reply, {});
            break;
        }
        case "RestoreSecret": {
            try {
                const secret = store.restoreSecret(body.SecretId);
                jsonReply(reply, { ARN: secret.arn, Name: secret.name });
            }
            catch (err) {
                const msg = err instanceof Error ? err.message : String(err);
                jsonReply(reply, { __type: "ResourceNotFoundException", message: msg }, 400);
            }
            break;
        }
        case "ListSecretVersionIds": {
            try {
                const versions = store.listSecretVersionIds(body.SecretId);
                jsonReply(reply, { Versions: versions });
            }
            catch (err) {
                const msg = err instanceof Error ? err.message : String(err);
                jsonReply(reply, { __type: "ResourceNotFoundException", message: msg }, 400);
            }
            break;
        }
        case "GetResourcePolicy": {
            const secret = store.getSecret(body.SecretId);
            if (!secret) {
                jsonReply(reply, { __type: "ResourceNotFoundException", message: `Secret ${body.SecretId} not found` }, 400);
                return;
            }
            jsonReply(reply, { ARN: secret.arn, Name: secret.name, ResourcePolicy: "" });
            break;
        }
        case "PutResourcePolicy":
        case "RotateSecret": {
            jsonReply(reply, {});
            break;
        }
        default: {
            jsonReply(reply, {
                __type: "UnknownOperationException",
                message: `lws: SecretsManager operation '${operation}' is not yet implemented`,
            }, 400);
        }
    }
}
//# sourceMappingURL=index.js.map