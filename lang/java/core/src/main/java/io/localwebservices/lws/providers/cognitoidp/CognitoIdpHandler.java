package io.localwebservices.lws.providers.cognitoidp;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.util.*;

/**
 * Cognito IDP wire-protocol HTTP handler.
 *
 * <p>Implements: user pools, users, groups, and admin auth flows.
 */
public class CognitoIdpHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String TARGET_PREFIX = "AWSCognitoIdentityProviderService.";

  private final ServerState state;
  private final CognitoIdpStore store;
  private final CognitoIdpHelpers helpers;
  private final CognitoIdpPoolOps poolOps;
  private final CognitoIdpGroupOps groupOps;

  /** Constructs a new CognitoIdpHandler. */
  public CognitoIdpHandler(ServerState state) {
    this.state = state;
    this.store = new CognitoIdpStore();
    this.helpers = new CognitoIdpHelpers(store);
    this.poolOps = new CognitoIdpPoolOps(store, helpers);
    this.groupOps = new CognitoIdpGroupOps(store, helpers);
    state.resetCallbacks.add(store::reset);
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
    if (target == null) target = "";
    String operation =
        target.startsWith(TARGET_PREFIX) ? target.substring(TARGET_PREFIX.length()) : target;

    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> body =
        bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();

    try {
      if (IamMiddleware.applyIamAuth(state, "cognito-idp", operation, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "cognito-idp", operation, exchange, false)) return;

      handleOperation(operation, body, exchange);

    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      helpers.sendJson(
          exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "Error";
      String type = deriveErrorType(msg);
      helpers.sendJson(exchange, 400, Map.of("__type", type, "message", msg));
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
    if (poolOps.handle(operation, body, exchange)) return;
    if (groupOps.handle(operation, body, exchange)) return;

    switch (operation) {
      case "AdminCreateUser":
        handleAdminCreateUser(body, exchange);
        break;

      case "AdminGetUser":
        handleAdminGetUser(body, exchange);
        break;

      case "AdminDeleteUser":
        {
          String poolId = (String) body.get("UserPoolId");
          String username = (String) body.get("Username");
          helpers.requireUser(poolId, username);
          helpers.requirePoolUsers(poolId).remove(username);
          helpers.sendJson(exchange, 200, Map.of());
          break;
        }

      case "ListUsers":
        {
          String poolId = (String) body.get("UserPoolId");
          Map<String, Map<String, Object>> poolUsers = helpers.requirePoolUsers(poolId);
          List<Map<String, Object>> userList = new ArrayList<>();
          for (Map<String, Object> u : poolUsers.values()) {
            userList.add(CognitoIdpHelpers.formatUserShort(u));
          }
          helpers.sendJson(exchange, 200, Map.of("Users", userList));
          break;
        }

      case "AdminConfirmSignUp":
        {
          String poolId = (String) body.get("UserPoolId");
          String username = (String) body.get("Username");
          Map<String, Object> user = helpers.requireUser(poolId, username);
          user.put("UserStatus", "CONFIRMED");
          user.put("UserLastModifiedDate", CognitoIdpHelpers.nowSeconds());
          helpers.sendJson(exchange, 200, Map.of());
          break;
        }

      case "AdminDisableUser":
        {
          String poolId = (String) body.get("UserPoolId");
          String username = (String) body.get("Username");
          Map<String, Object> user = helpers.requireUser(poolId, username);
          user.put("Enabled", false);
          user.put("UserLastModifiedDate", CognitoIdpHelpers.nowSeconds());
          helpers.sendJson(exchange, 200, Map.of());
          break;
        }

      case "AdminEnableUser":
        {
          String poolId = (String) body.get("UserPoolId");
          String username = (String) body.get("Username");
          Map<String, Object> user = helpers.requireUser(poolId, username);
          user.put("Enabled", true);
          user.put("UserLastModifiedDate", CognitoIdpHelpers.nowSeconds());
          helpers.sendJson(exchange, 200, Map.of());
          break;
        }

      case "AdminSetUserPassword":
        handleAdminSetUserPassword(body, exchange);
        break;

      case "AdminResetUserPassword":
        {
          String poolId = (String) body.get("UserPoolId");
          String username = (String) body.get("Username");
          Map<String, Object> user = helpers.requireUser(poolId, username);
          user.put("UserStatus", "FORCE_CHANGE_PASSWORD");
          user.put("TemporaryPassword", null);
          user.put("UserLastModifiedDate", CognitoIdpHelpers.nowSeconds());
          helpers.sendJson(exchange, 200, Map.of());
          break;
        }

      case "AdminUpdateUserAttributes":
        handleAdminUpdateUserAttributes(body, exchange);
        break;

      case "AdminUserGlobalSignOut":
      case "GlobalSignOut":
      case "AdminSetUserMFAPreference":
      case "SetUserMFAPreference":
        helpers.sendJson(exchange, 200, Map.of());
        break;

      case "AdminInitiateAuth":
        {
          String poolId = (String) body.get("UserPoolId");
          String authFlow = (String) body.get("AuthFlow");
          Map<String, String> authParams =
              (Map<String, String>) body.getOrDefault("AuthParameters", Map.of());
          helpers.sendJson(exchange, 200, helpers.doAuth(poolId, authFlow, authParams));
          break;
        }

      case "InitiateAuth":
        handleInitiateAuth(body, exchange);
        break;

      case "RespondToAuthChallenge":
      case "AdminRespondToAuthChallenge":
        handleRespondToAuthChallenge(body, exchange);
        break;

      case "SignUp":
        handleSignUp(body, exchange);
        break;

      case "ConfirmSignUp":
        handleConfirmSignUp(body, exchange);
        break;

      case "ForgotPassword":
        helpers.sendJson(
            exchange,
            200,
            Map.of(
                "CodeDeliveryDetails",
                Map.of(
                    "Destination", "***@example.com",
                    "DeliveryMedium", "EMAIL",
                    "AttributeName", "email")));
        break;

      case "ConfirmForgotPassword":
        handleConfirmForgotPassword(body, exchange);
        break;

      case "ChangePassword":
      case "GetUser":
      case "UpdateUserAttributes":
        helpers.sendJson(exchange, 200, Map.of("UserAttributes", List.of()));
        break;

      default:
        helpers.sendJson(
            exchange,
            400,
            Map.of(
                "__type",
                "UnknownOperationException",
                "message",
                "lws: CognitoIDP operation '" + operation + "' is not yet implemented"));
    }
  }

  @SuppressWarnings("unchecked")
  private void handleAdminCreateUser(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String poolId = (String) body.get("UserPoolId");
    String username = (String) body.get("Username");
    String tempPassword = (String) body.get("TemporaryPassword");
    Map<String, Map<String, Object>> poolUsers = helpers.requirePoolUsers(poolId);
    if (poolUsers.containsKey(username)) {
      throw new IllegalArgumentException(
          "UsernameExistsException: User " + username + " already exists");
    }
    List<Object> attrs = (List<Object>) body.getOrDefault("UserAttributes", List.of());
    double now = CognitoIdpHelpers.nowSeconds();
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
    helpers.sendJson(exchange, 200, Map.of("User", CognitoIdpHelpers.formatUser(user)));
  }

  private void handleAdminGetUser(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String poolId = (String) body.get("UserPoolId");
    String username = (String) body.get("Username");
    Map<String, Object> user = helpers.requireUser(poolId, username);
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("Username", user.get("Username"));
    result.put("UserAttributes", user.get("UserAttributes"));
    result.put("UserStatus", user.get("UserStatus"));
    result.put("Enabled", user.get("Enabled"));
    result.put("UserCreateDate", user.get("UserCreateDate"));
    result.put("UserLastModifiedDate", user.get("UserLastModifiedDate"));
    helpers.sendJson(exchange, 200, result);
  }

  private void handleAdminSetUserPassword(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String poolId = (String) body.get("UserPoolId");
    String username = (String) body.get("Username");
    String password = (String) body.get("Password");
    boolean permanent = Boolean.TRUE.equals(body.get("Permanent"));
    Map<String, Object> user = helpers.requireUser(poolId, username);
    user.put("Password", password);
    if (permanent) {
      user.put("UserStatus", "CONFIRMED");
      user.put("TemporaryPassword", null);
    } else {
      user.put("TemporaryPassword", password);
      user.put("UserStatus", "FORCE_CHANGE_PASSWORD");
    }
    user.put("UserLastModifiedDate", CognitoIdpHelpers.nowSeconds());
    helpers.sendJson(exchange, 200, Map.of());
  }

  @SuppressWarnings("unchecked")
  private void handleAdminUpdateUserAttributes(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String poolId = (String) body.get("UserPoolId");
    String username = (String) body.get("Username");
    Map<String, Object> user = helpers.requireUser(poolId, username);
    List<Map<String, Object>> newAttrs =
        (List<Map<String, Object>>) body.getOrDefault("UserAttributes", List.of());
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
    user.put("UserLastModifiedDate", CognitoIdpHelpers.nowSeconds());
    helpers.sendJson(exchange, 200, Map.of());
  }

  @SuppressWarnings("unchecked")
  private void handleInitiateAuth(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String clientId = (String) body.get("ClientId");
    Map<String, Object> client = store.clients.get(clientId);
    if (client == null) {
      helpers.sendJson(
          exchange,
          400,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Client not found: " + clientId));
      return;
    }
    String poolId = (String) client.get("UserPoolId");
    String authFlow = (String) body.get("AuthFlow");
    Map<String, String> authParams =
        (Map<String, String>) body.getOrDefault("AuthParameters", Map.of());
    helpers.sendJson(exchange, 200, helpers.doAuth(poolId, authFlow, authParams));
  }

  @SuppressWarnings("unchecked")
  private void handleRespondToAuthChallenge(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String sessionToken = (String) body.get("Session");
    String challengeName = (String) body.get("ChallengeName");
    Map<String, String> responses =
        (Map<String, String>) body.getOrDefault("ChallengeResponses", Map.of());
    Map<String, Object> session = store.authSessions.remove(sessionToken);
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
      Map<String, Object> user = helpers.requireUser(poolId, username);
      user.put("Password", newPassword);
      user.put("UserStatus", "CONFIRMED");
      user.put("TemporaryPassword", null);
      user.put("UserLastModifiedDate", CognitoIdpHelpers.nowSeconds());
      Map<String, Object> tokens =
          helpers.makeTokens(poolId, username, (List<Object>) user.get("UserAttributes"));
      helpers.sendJson(exchange, 200, Map.of("AuthenticationResult", tokens));
    } else {
      throw new IllegalArgumentException(
          "NotAuthorizedException: Challenge " + challengeName + " not supported");
    }
  }

  @SuppressWarnings("unchecked")
  private void handleSignUp(Map<String, Object> body, HttpExchange exchange) throws IOException {
    String clientId = (String) body.get("ClientId");
    Map<String, Object> client = store.clients.get(clientId);
    if (client == null) {
      helpers.sendJson(
          exchange,
          400,
          Map.of("__type", "ResourceNotFoundException", "message", "Client not found"));
      return;
    }
    String poolId = (String) client.get("UserPoolId");
    String username = (String) body.get("Username");
    String password = (String) body.get("Password");
    List<Object> attrs = (List<Object>) body.getOrDefault("UserAttributes", List.of());
    Map<String, Map<String, Object>> poolUsers = helpers.requirePoolUsers(poolId);
    if (poolUsers.containsKey(username)) {
      throw new IllegalArgumentException(
          "UsernameExistsException: User " + username + " already exists");
    }
    double now = CognitoIdpHelpers.nowSeconds();
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
    helpers.sendJson(exchange, 200, Map.of("UserConfirmed", false, "UserSub", username));
  }

  private void handleConfirmSignUp(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String clientId = (String) body.get("ClientId");
    Map<String, Object> client = store.clients.get(clientId);
    if (client == null) {
      helpers.sendJson(
          exchange,
          400,
          Map.of("__type", "ResourceNotFoundException", "message", "Client not found"));
      return;
    }
    String poolId = (String) client.get("UserPoolId");
    String username = (String) body.get("Username");
    Map<String, Object> user = helpers.requireUser(poolId, username);
    user.put("UserStatus", "CONFIRMED");
    user.put("UserLastModifiedDate", CognitoIdpHelpers.nowSeconds());
    helpers.sendJson(exchange, 200, Map.of());
  }

  private void handleConfirmForgotPassword(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String clientId = (String) body.get("ClientId");
    Map<String, Object> client = store.clients.get(clientId);
    if (client == null) {
      helpers.sendJson(
          exchange,
          400,
          Map.of("__type", "ResourceNotFoundException", "message", "Client not found"));
      return;
    }
    String poolId = (String) client.get("UserPoolId");
    Map<String, Object> user = helpers.requireUser(poolId, (String) body.get("Username"));
    user.put("Password", body.get("Password"));
    user.put("UserStatus", "CONFIRMED");
    user.put("UserLastModifiedDate", CognitoIdpHelpers.nowSeconds());
    helpers.sendJson(exchange, 200, Map.of());
  }
}
