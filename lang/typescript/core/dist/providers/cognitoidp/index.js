"use strict";
/** Cognito IDP wire-protocol stub — handles IAM auth, chaos, and fake middleware; all other operations return not-implemented. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.registerCognitoIdp = registerCognitoIdp;
const chaos_1 = require("../../middleware/chaos");
const fake_1 = require("../../middleware/fake");
const iam_1 = require("../../middleware/iam");
const logging_1 = require("../../middleware/logging");
function jsonReply(reply, data, status = 200) {
    reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}
const TARGET_PREFIX = "AWSCognitoIdentityProviderService.";
// Normalize AWS operation name to kebab-case
function operationToKebab(op) {
    return op.replace(/([a-z])([A-Z])/g, "$1-$2").toLowerCase();
}
function registerCognitoIdp(app, state) {
    app.post("/", async (req, reply) => {
        const target = req.headers["x-amz-target"] ?? "";
        const rawOperation = target.startsWith(TARGET_PREFIX) ? target.slice(TARGET_PREFIX.length) : target;
        const operation = operationToKebab(rawOperation) || rawOperation;
        const ctx = (0, logging_1.createRequestContext)("cognitoidp", operation);
        if (await (0, iam_1.applyIamAuth)(state, "cognito-idp", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, chaos_1.applyChaos)(state, "cognito-idp", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "cognito-idp", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        // Return a minimal success response for all operations (stub)
        jsonReply(reply, { message: `pending cognito: ${operation}` }, 200);
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
}
//# sourceMappingURL=index.js.map