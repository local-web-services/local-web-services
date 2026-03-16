package io.localwebservices.lws.providers.cognitoidp;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Cognito IDP wire-protocol HTTP handler.
 *
 * Implements: user pools, users, groups, and admin auth flows.
 */
public class CognitoIdpHandler implements HttpHandler {

    private static final ObjectMapper MAPPER = new ObjectMapper();
    private static final String TARGET_PREFIX = "AWSCognitoIdentityProviderService.";
    private static final String REGION = "us-east-1";
    private static final String ACCOUNT = "000000000000";

    private final ServerState state;

    // Pool storage: poolId → pool attributes
    private final Map<String, Map<String, Object>> pools = new ConcurrentHashMap<>();
    // Users: poolId → username → user
    private final Map<String, Map<String, Map<String, Object>>> users = new ConcurrentHashMap<>();
    // Groups: poolId → groupName → group
    private final Map<String, Map<String, Map<String, Object>>> groups = new ConcurrentHashMap<>();
    // Group members: poolId → groupName → Set<username>
    private final Map<String, Map<String, Set<String>>> groupMembers = new ConcurrentHashMap<>();
    // Clients: clientId → client attributes
    private final Map<String, Map<String, Object>> clients = new ConcurrentHashMap<>();
    // Auth sessions: session → session attributes
    private final Map<String, Map<String, Object>> authSessions = new ConcurrentHashMap<>();

    public CognitoIdpHandler(ServerState state) {
        this.state = state;
        state.resetCallbacks.add(this::reset);
    }

    private void reset() {
        pools.clear();
        users.clear();
        groups.clear();
        groupMembers.clear();
        clients.clear();
        authSessions.clear();
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
        if (target == null) target = "";
        String operation = target.startsWith(TARGET_PREFIX) ? target.substring(TARGET_PREFIX.length()) : target;

        byte[] bodyBytes;
        try (InputStream is = exchange.getRequestBody()) {
            bodyBytes = is.readAllBytes();
        }
        @SuppressWarnings("unchecked")
        Map<String, Object> body = bodyBytes.length > 0
                ? MAPPER.readValue(bodyBytes, Map.class)
                : new LinkedHashMap<>();

        try {
            if (IamMiddleware.applyIamAuth(state, "cognito-idp", operation, exchange, false)) return;
            if (ChaosMiddleware.applyChaos(state, "cognito-idp", operation, exchange, false)) return;

            handleOperation(operation, body, exchange);

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
        } catch (Exception e) {
            String msg = e.getMessage() != null ? e.getMessage() : "Error";
            String type = deriveErrorType(msg);
            sendJson(exchange, 400, Map.of("__type", type, "message", msg));
        }
    }

    private String deriveErrorType(String msg) {
        if (msg.contains("UserNotFoundException")) return "UserNotFoundException";
        if (msg.contains("UsernameExistsException")) return "UsernameExistsException";
        if (msg.contains("ResourceNotFoundException")) return "ResourceNotFoundException";
        if (msg.contains("GroupExistsException")) return "GroupExistsException";
        if (msg.contains("NotAuthorizedException")) return "NotAuthorizedException";
        if (msg.contains("InvalidParameterException")) return "InvalidParameterException";
        return "InvalidRequestException";
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange)
            throws IOException {
        switch (operation) {

            // ── User Pools ────────────────────────────────────────────────────

            case "CreateUserPool": {
                String name = (String) body.get("PoolName");
                String id = REGION + "_" + uuid9();
                double now = nowSeconds();
                Map<String, Object> pool = new LinkedHashMap<>();
                pool.put("Id", id);
                pool.put("Name", name);
                pool.put("Arn", "arn:aws:cognito-idp:" + REGION + ":" + ACCOUNT + ":userpool/" + id);
                pool.put("Status", "Active");
                pool.put("CreationDate", now);
                pool.put("LastModifiedDate", now);
                pools.put(id, pool);
                users.put(id, new ConcurrentHashMap<>());
                groups.put(id, new ConcurrentHashMap<>());
                groupMembers.put(id, new ConcurrentHashMap<>());
                sendJson(exchange, 200, Map.of("UserPool", pool));
                break;
            }

            case "DeleteUserPool": {
                String poolId = (String) body.get("UserPoolId");
                requirePool(poolId);
                pools.remove(poolId);
                users.remove(poolId);
                groups.remove(poolId);
                groupMembers.remove(poolId);
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "DescribeUserPool": {
                String poolId = (String) body.get("UserPoolId");
                sendJson(exchange, 200, Map.of("UserPool", requirePool(poolId)));
                break;
            }

            case "ListUserPools": {
                List<Map<String, Object>> list = new ArrayList<>();
                for (Map<String, Object> p : pools.values()) {
                    Map<String, Object> entry = new LinkedHashMap<>();
                    entry.put("Id", p.get("Id"));
                    entry.put("Name", p.get("Name"));
                    entry.put("Status", p.get("Status"));
                    entry.put("CreationDate", p.get("CreationDate"));
                    entry.put("LastModifiedDate", p.get("LastModifiedDate"));
                    list.add(entry);
                }
                sendJson(exchange, 200, Map.of("UserPools", list));
                break;
            }

            case "UpdateUserPool": {
                sendJson(exchange, 200, Map.of());
                break;
            }

            // ── User Pool Clients ─────────────────────────────────────────────

            case "CreateUserPoolClient": {
                String poolId = (String) body.get("UserPoolId");
                requirePool(poolId);
                String clientName = (String) body.get("ClientName");
                String clientId = uuid26();
                double now = nowSeconds();
                Map<String, Object> client = new LinkedHashMap<>();
                client.put("ClientId", clientId);
                client.put("ClientName", clientName);
                client.put("UserPoolId", poolId);
                client.put("CreationDate", now);
                client.put("LastModifiedDate", now);
                clients.put(clientId, client);
                sendJson(exchange, 200, Map.of("UserPoolClient", client));
                break;
            }

            case "DescribeUserPoolClient": {
                String clientId = (String) body.get("ClientId");
                Map<String, Object> client = clients.get(clientId);
                if (client == null) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Client not found: " + clientId));
                    return;
                }
                sendJson(exchange, 200, Map.of("UserPoolClient", client));
                break;
            }

            case "DeleteUserPoolClient": {
                String clientId = (String) body.get("ClientId");
                clients.remove(clientId);
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "UpdateUserPoolClient":
            case "ListUserPoolClients": {
                sendJson(exchange, 200, Map.of("UserPoolClients", List.of()));
                break;
            }

            // ── Users ─────────────────────────────────────────────────────────

            case "AdminCreateUser": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                String tempPassword = (String) body.get("TemporaryPassword");
                Map<String, Map<String, Object>> poolUsers = requirePoolUsers(poolId);
                if (poolUsers.containsKey(username)) {
                    throw new IllegalArgumentException("UsernameExistsException: User " + username + " already exists");
                }
                List<Object> attrs = (List<Object>) body.getOrDefault("UserAttributes", List.of());
                double now = nowSeconds();
                Map<String, Object> user = new LinkedHashMap<>();
                user.put("Username", username);
                user.put("UserStatus", tempPassword != null ? "FORCE_CHANGE_PASSWORD" : "UNCONFIRMED");
                user.put("Enabled", true);
                user.put("Password", tempPassword != null ? tempPassword : "");
                user.put("TemporaryPassword", tempPassword);
                user.put("UserAttributes", attrs);
                user.put("UserCreateDate", now);
                user.put("UserLastModifiedDate", now);
                poolUsers.put(username, user);
                sendJson(exchange, 200, Map.of("User", formatUser(user)));
                break;
            }

            case "AdminGetUser": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                Map<String, Object> user = requireUser(poolId, username);
                Map<String, Object> result = new LinkedHashMap<>();
                result.put("Username", user.get("Username"));
                result.put("UserAttributes", user.get("UserAttributes"));
                result.put("UserStatus", user.get("UserStatus"));
                result.put("Enabled", user.get("Enabled"));
                result.put("UserCreateDate", user.get("UserCreateDate"));
                result.put("UserLastModifiedDate", user.get("UserLastModifiedDate"));
                sendJson(exchange, 200, result);
                break;
            }

            case "AdminDeleteUser": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                requireUser(poolId, username);
                requirePoolUsers(poolId).remove(username);
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "ListUsers": {
                String poolId = (String) body.get("UserPoolId");
                Map<String, Map<String, Object>> poolUsers = requirePoolUsers(poolId);
                List<Map<String, Object>> userList = new ArrayList<>();
                for (Map<String, Object> u : poolUsers.values()) {
                    userList.add(formatUserShort(u));
                }
                sendJson(exchange, 200, Map.of("Users", userList));
                break;
            }

            case "AdminConfirmSignUp": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                Map<String, Object> user = requireUser(poolId, username);
                user.put("UserStatus", "CONFIRMED");
                user.put("UserLastModifiedDate", nowSeconds());
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "AdminDisableUser": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                Map<String, Object> user = requireUser(poolId, username);
                user.put("Enabled", false);
                user.put("UserLastModifiedDate", nowSeconds());
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "AdminEnableUser": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                Map<String, Object> user = requireUser(poolId, username);
                user.put("Enabled", true);
                user.put("UserLastModifiedDate", nowSeconds());
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "AdminSetUserPassword": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                String password = (String) body.get("Password");
                boolean permanent = Boolean.TRUE.equals(body.get("Permanent"));
                Map<String, Object> user = requireUser(poolId, username);
                user.put("Password", password);
                if (permanent) {
                    user.put("UserStatus", "CONFIRMED");
                    user.put("TemporaryPassword", null);
                } else {
                    user.put("TemporaryPassword", password);
                    user.put("UserStatus", "FORCE_CHANGE_PASSWORD");
                }
                user.put("UserLastModifiedDate", nowSeconds());
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "AdminResetUserPassword": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                Map<String, Object> user = requireUser(poolId, username);
                user.put("UserStatus", "FORCE_CHANGE_PASSWORD");
                user.put("TemporaryPassword", null);
                user.put("UserLastModifiedDate", nowSeconds());
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "AdminUpdateUserAttributes": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                Map<String, Object> user = requireUser(poolId, username);
                List<Map<String, Object>> newAttrs = (List<Map<String, Object>>) body.getOrDefault("UserAttributes", List.of());
                List<Map<String, Object>> existing = (List<Map<String, Object>>) user.get("UserAttributes");
                if (existing == null) existing = new ArrayList<>();
                for (Map<String, Object> newAttr : newAttrs) {
                    String attrName = (String) newAttr.get("Name");
                    boolean found = false;
                    for (Map<String, Object> a : existing) {
                        if (attrName.equals(a.get("Name"))) {
                            a.put("Value", newAttr.get("Value"));
                            found = true;
                            break;
                        }
                    }
                    if (!found) existing.add(newAttr);
                }
                user.put("UserAttributes", existing);
                user.put("UserLastModifiedDate", nowSeconds());
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "AdminUserGlobalSignOut":
            case "GlobalSignOut":
            case "AdminSetUserMFAPreference":
            case "SetUserMFAPreference": {
                sendJson(exchange, 200, Map.of());
                break;
            }

            // ── Groups ─────────────────────────────────────────────────────────

            case "CreateGroup": {
                String poolId = (String) body.get("UserPoolId");
                requirePool(poolId);
                String groupName = (String) body.get("GroupName");
                Map<String, Map<String, Object>> poolGroups = groups.get(poolId);
                if (poolGroups.containsKey(groupName)) {
                    throw new IllegalArgumentException("GroupExistsException: Group " + groupName + " already exists");
                }
                double now = nowSeconds();
                Map<String, Object> group = new LinkedHashMap<>();
                group.put("GroupName", groupName);
                group.put("UserPoolId", poolId);
                group.put("Description", body.getOrDefault("Description", ""));
                group.put("Precedence", body.getOrDefault("Precedence", 0));
                group.put("CreationDate", now);
                group.put("LastModifiedDate", now);
                poolGroups.put(groupName, group);
                groupMembers.get(poolId).put(groupName, new HashSet<>());
                sendJson(exchange, 200, Map.of("Group", group));
                break;
            }

            case "DeleteGroup": {
                String poolId = (String) body.get("UserPoolId");
                String groupName = (String) body.get("GroupName");
                Map<String, Map<String, Object>> poolGroups = groups.get(poolId);
                if (poolGroups == null || !poolGroups.containsKey(groupName)) {
                    throw new IllegalArgumentException("ResourceNotFoundException: Group " + groupName + " not found");
                }
                poolGroups.remove(groupName);
                groupMembers.get(poolId).remove(groupName);
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "GetGroup": {
                String poolId = (String) body.get("UserPoolId");
                String groupName = (String) body.get("GroupName");
                Map<String, Object> group = requireGroup(poolId, groupName);
                sendJson(exchange, 200, Map.of("Group", group));
                break;
            }

            case "ListGroups": {
                String poolId = (String) body.get("UserPoolId");
                requirePool(poolId);
                List<Map<String, Object>> groupList = new ArrayList<>(groups.get(poolId).values());
                sendJson(exchange, 200, Map.of("Groups", groupList));
                break;
            }

            case "AdminAddUserToGroup": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                String groupName = (String) body.get("GroupName");
                requireUser(poolId, username);
                requireGroup(poolId, groupName);
                groupMembers.get(poolId).get(groupName).add(username);
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "AdminRemoveUserFromGroup": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                String groupName = (String) body.get("GroupName");
                Set<String> members = groupMembers.getOrDefault(poolId, Map.of()).get(groupName);
                if (members != null) members.remove(username);
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "ListUsersInGroup": {
                String poolId = (String) body.get("UserPoolId");
                String groupName = (String) body.get("GroupName");
                requireGroup(poolId, groupName);
                Set<String> members = groupMembers.get(poolId).getOrDefault(groupName, Set.of());
                Map<String, Map<String, Object>> poolUsers = requirePoolUsers(poolId);
                List<Map<String, Object>> userList = new ArrayList<>();
                for (String username : members) {
                    Map<String, Object> u = poolUsers.get(username);
                    if (u != null) userList.add(formatUserShort(u));
                }
                sendJson(exchange, 200, Map.of("Users", userList));
                break;
            }

            case "AdminListGroupsForUser": {
                String poolId = (String) body.get("UserPoolId");
                String username = (String) body.get("Username");
                requireUser(poolId, username);
                List<Map<String, Object>> userGroups = new ArrayList<>();
                Map<String, Set<String>> poolGroupMembers = groupMembers.get(poolId);
                if (poolGroupMembers != null) {
                    for (Map.Entry<String, Set<String>> entry : poolGroupMembers.entrySet()) {
                        if (entry.getValue().contains(username)) {
                            Map<String, Object> g = groups.get(poolId).get(entry.getKey());
                            if (g != null) userGroups.add(g);
                        }
                    }
                }
                sendJson(exchange, 200, Map.of("Groups", userGroups));
                break;
            }

            // ── Auth ───────────────────────────────────────────────────────────

            case "AdminInitiateAuth": {
                String poolId = (String) body.get("UserPoolId");
                String authFlow = (String) body.get("AuthFlow");
                Map<String, String> authParams = (Map<String, String>) body.getOrDefault("AuthParameters", Map.of());
                Map<String, Object> result = doAuth(poolId, authFlow, authParams);
                sendJson(exchange, 200, result);
                break;
            }

            case "InitiateAuth": {
                String clientId = (String) body.get("ClientId");
                Map<String, Object> client = clients.get(clientId);
                if (client == null) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Client not found: " + clientId));
                    return;
                }
                String poolId = (String) client.get("UserPoolId");
                String authFlow = (String) body.get("AuthFlow");
                Map<String, String> authParams = (Map<String, String>) body.getOrDefault("AuthParameters", Map.of());
                Map<String, Object> result = doAuth(poolId, authFlow, authParams);
                sendJson(exchange, 200, result);
                break;
            }

            case "RespondToAuthChallenge":
            case "AdminRespondToAuthChallenge": {
                String sessionToken = (String) body.get("Session");
                String challengeName = (String) body.get("ChallengeName");
                Map<String, String> responses = (Map<String, String>) body.getOrDefault("ChallengeResponses", Map.of());
                Map<String, Object> session = authSessions.remove(sessionToken);
                if (session == null) {
                    throw new IllegalArgumentException("NotAuthorizedException: Invalid session");
                }
                if ("NEW_PASSWORD_REQUIRED".equals(challengeName)) {
                    String newPassword = responses.get("NEW_PASSWORD");
                    if (newPassword == null) {
                        throw new IllegalArgumentException("InvalidParameterException: NEW_PASSWORD required");
                    }
                    String poolId = (String) session.get("poolId");
                    String username = (String) session.get("username");
                    Map<String, Object> user = requireUser(poolId, username);
                    user.put("Password", newPassword);
                    user.put("UserStatus", "CONFIRMED");
                    user.put("TemporaryPassword", null);
                    user.put("UserLastModifiedDate", nowSeconds());
                    Map<String, Object> tokens = makeTokens(poolId, username, (List<Object>) user.get("UserAttributes"));
                    sendJson(exchange, 200, Map.of("AuthenticationResult", tokens));
                } else {
                    throw new IllegalArgumentException("NotAuthorizedException: Challenge " + challengeName + " not supported");
                }
                break;
            }

            // ── Sign-up flows ───────────────────────────────────────────────────

            case "SignUp": {
                String clientId = (String) body.get("ClientId");
                Map<String, Object> client = clients.get(clientId);
                if (client == null) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Client not found"));
                    return;
                }
                String poolId = (String) client.get("UserPoolId");
                String username = (String) body.get("Username");
                String password = (String) body.get("Password");
                List<Object> attrs = (List<Object>) body.getOrDefault("UserAttributes", List.of());
                Map<String, Map<String, Object>> poolUsers = requirePoolUsers(poolId);
                if (poolUsers.containsKey(username)) {
                    throw new IllegalArgumentException("UsernameExistsException: User " + username + " already exists");
                }
                double now = nowSeconds();
                Map<String, Object> user = new LinkedHashMap<>();
                user.put("Username", username);
                user.put("UserStatus", "UNCONFIRMED");
                user.put("Enabled", true);
                user.put("Password", password);
                user.put("TemporaryPassword", null);
                user.put("UserAttributes", attrs);
                user.put("UserCreateDate", now);
                user.put("UserLastModifiedDate", now);
                poolUsers.put(username, user);
                sendJson(exchange, 200, Map.of(
                    "UserConfirmed", false,
                    "UserSub", username
                ));
                break;
            }

            case "ConfirmSignUp": {
                String clientId = (String) body.get("ClientId");
                Map<String, Object> client = clients.get(clientId);
                if (client == null) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Client not found"));
                    return;
                }
                String poolId = (String) client.get("UserPoolId");
                String username = (String) body.get("Username");
                Map<String, Object> user = requireUser(poolId, username);
                user.put("UserStatus", "CONFIRMED");
                user.put("UserLastModifiedDate", nowSeconds());
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "ForgotPassword": {
                sendJson(exchange, 200, Map.of(
                    "CodeDeliveryDetails", Map.of(
                        "Destination", "***@example.com",
                        "DeliveryMedium", "EMAIL",
                        "AttributeName", "email"
                    )
                ));
                break;
            }

            case "ConfirmForgotPassword": {
                String clientId = (String) body.get("ClientId");
                Map<String, Object> client = clients.get(clientId);
                if (client == null) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Client not found"));
                    return;
                }
                String poolId = (String) client.get("UserPoolId");
                Map<String, Object> user = requireUser(poolId, (String) body.get("Username"));
                user.put("Password", body.get("Password"));
                user.put("UserStatus", "CONFIRMED");
                user.put("UserLastModifiedDate", nowSeconds());
                sendJson(exchange, 200, Map.of());
                break;
            }

            case "ChangePassword":
            case "GetUser":
            case "UpdateUserAttributes": {
                sendJson(exchange, 200, Map.of("UserAttributes", List.of()));
                break;
            }

            default: {
                sendJson(exchange, 400, Map.of(
                    "__type", "UnknownOperationException",
                    "message", "lws: CognitoIDP operation '" + operation + "' is not yet implemented"
                ));
            }
        }
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> doAuth(String poolId, String authFlow, Map<String, String> authParams) {
        requirePool(poolId);
        if ("ADMIN_USER_PASSWORD_AUTH".equals(authFlow)) {
            String username = authParams.get("USERNAME");
            String password = authParams.get("PASSWORD");
            Map<String, Object> user = requireUser(poolId, username);
            if (!Boolean.TRUE.equals(user.get("Enabled"))) {
                throw new IllegalArgumentException("NotAuthorizedException: User is disabled");
            }
            String storedPassword = (String) user.get("Password");
            String tempPassword = (String) user.get("TemporaryPassword");
            if (!password.equals(storedPassword) && !password.equals(tempPassword)) {
                throw new IllegalArgumentException("NotAuthorizedException: Incorrect username or password");
            }
            if ("FORCE_CHANGE_PASSWORD".equals(user.get("UserStatus"))) {
                String sessionToken = "lws-session-" + UUID.randomUUID();
                Map<String, Object> sessionData = Map.of("poolId", poolId, "username", username);
                authSessions.put(sessionToken, sessionData);
                return Map.of(
                    "ChallengeName", "NEW_PASSWORD_REQUIRED",
                    "Session", sessionToken,
                    "ChallengeParameters", Map.of("USER_ID_FOR_SRP", username)
                );
            }
            List<Object> attrs = (List<Object>) user.getOrDefault("UserAttributes", List.of());
            return Map.of("AuthenticationResult", makeTokens(poolId, username, attrs));
        }
        if ("REFRESH_TOKEN_AUTH".equals(authFlow) || "REFRESH_TOKEN".equals(authFlow)) {
            String username = authParams.getOrDefault("USERNAME", "unknown");
            Map<String, Map<String, Object>> poolUsers = users.get(poolId);
            Map<String, Object> user = poolUsers != null ? poolUsers.get(username) : null;
            if (user == null) {
                throw new IllegalArgumentException("NotAuthorizedException: Invalid refresh token");
            }
            List<Object> attrs = (List<Object>) user.getOrDefault("UserAttributes", List.of());
            return Map.of("AuthenticationResult", makeTokens(poolId, username, attrs));
        }
        throw new IllegalArgumentException("NotAuthorizedException: Auth flow " + authFlow + " not supported");
    }

    private Map<String, Object> makeTokens(String poolId, String username, List<Object> attributes) {
        long now = System.currentTimeMillis() / 1000;
        long exp = now + 3600;
        String sub = UUID.randomUUID().toString();

        String idHeader = b64url("{\"alg\":\"RS256\",\"kid\":\"lws-local\",\"typ\":\"JWT\"}");
        String idPayload = b64url("{\"sub\":\"" + sub + "\",\"iss\":\"https://cognito-idp." + REGION
                + ".amazonaws.com/" + poolId + "\",\"aud\":\"lws-local-client\",\"token_use\":\"id\","
                + "\"cognito_username\":\"" + username + "\","
                + "\"iat\":" + now + ",\"exp\":" + exp + "}");
        String idToken = idHeader + "." + idPayload + "." + b64url("lws-local-test-sig");

        String accessHeader = b64url("{\"alg\":\"RS256\",\"kid\":\"lws-local\",\"typ\":\"JWT\"}");
        String accessPayload = b64url("{\"sub\":\"" + sub + "\",\"iss\":\"https://cognito-idp." + REGION
                + ".amazonaws.com/" + poolId + "\",\"token_use\":\"access\","
                + "\"username\":\"" + username + "\","
                + "\"iat\":" + now + ",\"exp\":" + exp + "}");
        String accessToken = accessHeader + "." + accessPayload + "." + b64url("lws-local-test-sig");

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("IdToken", idToken);
        result.put("AccessToken", accessToken);
        result.put("RefreshToken", "lws-refresh-" + UUID.randomUUID());
        result.put("ExpiresIn", 3600);
        result.put("TokenType", "Bearer");
        return result;
    }

    private static String b64url(String input) {
        return Base64.getUrlEncoder().withoutPadding().encodeToString(input.getBytes(StandardCharsets.UTF_8));
    }

    private Map<String, Object> requirePool(String poolId) {
        Map<String, Object> pool = pools.get(poolId);
        if (pool == null) throw new IllegalArgumentException("ResourceNotFoundException: User pool " + poolId + " not found");
        return pool;
    }

    private Map<String, Map<String, Object>> requirePoolUsers(String poolId) {
        requirePool(poolId);
        return users.computeIfAbsent(poolId, k -> new ConcurrentHashMap<>());
    }

    private Map<String, Object> requireUser(String poolId, String username) {
        Map<String, Object> user = requirePoolUsers(poolId).get(username);
        if (user == null) throw new IllegalArgumentException("UserNotFoundException: User " + username + " not found");
        return user;
    }

    private Map<String, Object> requireGroup(String poolId, String groupName) {
        requirePool(poolId);
        Map<String, Map<String, Object>> poolGroups = groups.get(poolId);
        if (poolGroups == null || !poolGroups.containsKey(groupName)) {
            throw new IllegalArgumentException("ResourceNotFoundException: Group " + groupName + " not found");
        }
        return poolGroups.get(groupName);
    }

    private static Map<String, Object> formatUser(Map<String, Object> user) {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("Username", user.get("Username"));
        result.put("UserStatus", user.get("UserStatus"));
        result.put("Enabled", user.get("Enabled"));
        result.put("UserAttributes", user.get("UserAttributes"));
        result.put("UserCreateDate", user.get("UserCreateDate"));
        result.put("UserLastModifiedDate", user.get("UserLastModifiedDate"));
        return result;
    }

    private static Map<String, Object> formatUserShort(Map<String, Object> user) {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("Username", user.get("Username"));
        result.put("UserStatus", user.get("UserStatus"));
        result.put("Enabled", user.get("Enabled"));
        result.put("Attributes", user.get("UserAttributes"));
        result.put("UserCreateDate", user.get("UserCreateDate"));
        result.put("UserLastModifiedDate", user.get("UserLastModifiedDate"));
        return result;
    }

    private static double nowSeconds() {
        return System.currentTimeMillis() / 1000.0;
    }

    private static String uuid9() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 9);
    }

    private static String uuid26() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 26);
    }

    private void sendJson(HttpExchange exchange, int status, Object responseBody) throws IOException {
        byte[] bytes = MAPPER.writeValueAsBytes(responseBody);
        exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) {
            os.write(bytes);
        }
    }
}
