"use strict";
/** IAM policy evaluation middleware. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.applyIamAuth = applyIamAuth;
function wildcardMatch(pattern, value) {
    const escaped = pattern.replace(/[.+^${}()|[\]\\]/g, "\\$&");
    const regex = new RegExp("^" + escaped.replace(/\*/g, ".*").replace(/\?/g, ".") + "$", "i");
    return regex.test(value);
}
function evaluateStatement(stmt, action, resource) {
    const actions = Array.isArray(stmt.Action) ? stmt.Action : [stmt.Action];
    const resources = Array.isArray(stmt.Resource) ? stmt.Resource : [stmt.Resource];
    const actionMatch = actions.some((a) => wildcardMatch(a, action));
    const resourceMatch = resources.some((r) => wildcardMatch(r, resource));
    if (!actionMatch || !resourceMatch)
        return "no_match";
    return stmt.Effect === "Allow" ? "allow" : "deny";
}
function evaluatePolicy(policy, action, resource) {
    let result = "no_match";
    for (const stmt of policy.Statement ?? []) {
        const r = evaluateStatement(stmt, action, resource);
        if (r === "deny")
            return "deny";
        if (r === "allow")
            result = "allow";
    }
    return result;
}
function isAuthorized(state, accessKeyId, action, resource) {
    const { iamConfig } = state;
    // Determine which identity to use
    const defaultIdentity = iamConfig.default_identity;
    // Look up identity: try exact access key, then default_identity, then "default"
    const identity = iamConfig.identities[accessKeyId] ??
        (defaultIdentity ? iamConfig.identities[defaultIdentity] : undefined) ??
        iamConfig.identities["default"];
    if (!identity) {
        // No identity configured — implicit deny in enforce mode (unknown callers are rejected)
        return false;
    }
    // Explicit deny check in inline policies
    for (const policy of identity.inline_policies ?? []) {
        for (const stmt of policy.Statement ?? []) {
            if (stmt.Effect === "Deny") {
                const r = evaluateStatement(stmt, action, resource);
                if (r === "deny")
                    return false;
            }
        }
    }
    // Permission boundary check (if set, must have explicit allow)
    if (identity.permission_boundary) {
        const boundaryResult = evaluatePolicy(identity.permission_boundary, action, resource);
        if (boundaryResult !== "allow")
            return false;
    }
    // Identity policy allow check
    for (const policy of identity.inline_policies ?? []) {
        const r = evaluatePolicy(policy, action, resource);
        if (r === "allow")
            return true;
    }
    // Implicit deny
    return false;
}
async function applyIamAuth(state, service, operation, req, reply, xmlProtocol = false) {
    if (!state.iamConfig.enforce)
        return false;
    // Extract access key from Authorization header
    const authHeader = req.headers["authorization"] ?? "";
    const match = /Credential=([^/,]+)/.exec(authHeader);
    const accessKeyId = match ? match[1] : "anonymous";
    // Build action: service:Operation (e.g. states:StartExecution)
    const action = `${service.toLowerCase()}:${operation}`;
    const resource = "*";
    if (!isAuthorized(state, accessKeyId, action, resource)) {
        if (xmlProtocol) {
            reply.status(403)
                .header("Content-Type", "application/xml")
                .send(`<?xml version="1.0" encoding="UTF-8"?><Error><Code>AccessDenied</Code><Message>Access Denied: User is not authorized to perform: ${action}</Message></Error>`);
        }
        else {
            reply.status(403).send({
                __type: "AccessDeniedException",
                message: `User: arn:aws:iam::000000000000:user/${accessKeyId} is not authorized to perform: ${action}`,
            });
        }
        return true;
    }
    return false;
}
//# sourceMappingURL=iam.js.map