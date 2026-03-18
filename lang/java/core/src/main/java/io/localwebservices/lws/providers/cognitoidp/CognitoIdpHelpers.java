package io.localwebservices.lws.providers.cognitoidp;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** Helper methods for Cognito IDP handler. */
class CognitoIdpHelpers {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String REGION = "us-east-1";

  private final CognitoIdpStore store;

  CognitoIdpHelpers(CognitoIdpStore store) {
    this.store = store;
  }

  @SuppressWarnings("unchecked")
  Map<String, Object> doAuth(String poolId, String authFlow, Map<String, String> authParams) {
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
        throw new IllegalArgumentException(
            "NotAuthorizedException: Incorrect username or password");
      }
      if ("FORCE_CHANGE_PASSWORD".equals(user.get("UserStatus"))) {
        String sessionToken = "lws-session-" + UUID.randomUUID();
        Map<String, Object> sessionData = Map.of("poolId", poolId, "username", username);
        store.authSessions.put(sessionToken, sessionData);
        return Map.of(
            "ChallengeName",
            "NEW_PASSWORD_REQUIRED",
            "Session",
            sessionToken,
            "ChallengeParameters",
            Map.of("USER_ID_FOR_SRP", username));
      }
      List<Object> attrs = (List<Object>) user.getOrDefault("UserAttributes", List.of());
      return Map.of("AuthenticationResult", makeTokens(poolId, username, attrs));
    }
    if ("REFRESH_TOKEN_AUTH".equals(authFlow) || "REFRESH_TOKEN".equals(authFlow)) {
      String username = authParams.getOrDefault("USERNAME", "unknown");
      Map<String, Map<String, Object>> poolUsers = store.users.get(poolId);
      Map<String, Object> user = poolUsers != null ? poolUsers.get(username) : null;
      if (user == null) {
        throw new IllegalArgumentException("NotAuthorizedException: Invalid refresh token");
      }
      List<Object> attrs = (List<Object>) user.getOrDefault("UserAttributes", List.of());
      return Map.of("AuthenticationResult", makeTokens(poolId, username, attrs));
    }
    throw new IllegalArgumentException(
        "NotAuthorizedException: Auth flow " + authFlow + " not supported");
  }

  @SuppressWarnings("PMD.UnusedFormalParameter")
  Map<String, Object> makeTokens(String poolId, String username, List<Object> attributes) {
    long now = System.currentTimeMillis() / 1000;
    long exp = now + 3600;
    String sub = UUID.randomUUID().toString();

    String idHeader = b64url("{\"alg\":\"RS256\",\"kid\":\"lws-local\",\"typ\":\"JWT\"}");
    String idPayload =
        b64url(
            "{\"sub\":\""
                + sub
                + "\",\"iss\":\"https://cognito-idp."
                + REGION
                + ".amazonaws.com/"
                + poolId
                + "\",\"aud\":\"lws-local-client\",\"token_use\":\"id\","
                + "\"cognito_username\":\""
                + username
                + "\","
                + "\"iat\":"
                + now
                + ",\"exp\":"
                + exp
                + "}");
    String idToken = idHeader + "." + idPayload + "." + b64url("lws-local-test-sig");

    String accessHeader = b64url("{\"alg\":\"RS256\",\"kid\":\"lws-local\",\"typ\":\"JWT\"}");
    String accessPayload =
        b64url(
            "{\"sub\":\""
                + sub
                + "\",\"iss\":\"https://cognito-idp."
                + REGION
                + ".amazonaws.com/"
                + poolId
                + "\",\"token_use\":\"access\","
                + "\"username\":\""
                + username
                + "\","
                + "\"iat\":"
                + now
                + ",\"exp\":"
                + exp
                + "}");
    String accessToken = accessHeader + "." + accessPayload + "." + b64url("lws-local-test-sig");

    Map<String, Object> result = new LinkedHashMap<>();
    result.put("IdToken", idToken);
    result.put("AccessToken", accessToken);
    result.put("RefreshToken", "lws-refresh-" + UUID.randomUUID());
    result.put("ExpiresIn", 3600);
    result.put("TokenType", "Bearer");
    return result;
  }

  static String b64url(String input) {
    return Base64.getUrlEncoder()
        .withoutPadding()
        .encodeToString(input.getBytes(StandardCharsets.UTF_8));
  }

  Map<String, Object> requirePool(String poolId) {
    Map<String, Object> pool = store.pools.get(poolId);
    if (pool == null)
      throw new IllegalArgumentException(
          "ResourceNotFoundException: User pool " + poolId + " not found");
    return pool;
  }

  Map<String, Map<String, Object>> requirePoolUsers(String poolId) {
    requirePool(poolId);
    return store.users.computeIfAbsent(poolId, k -> new ConcurrentHashMap<>());
  }

  Map<String, Object> requireUser(String poolId, String username) {
    Map<String, Object> user = requirePoolUsers(poolId).get(username);
    if (user == null)
      throw new IllegalArgumentException("UserNotFoundException: User " + username + " not found");
    return user;
  }

  Map<String, Object> requireGroup(String poolId, String groupName) {
    requirePool(poolId);
    Map<String, Map<String, Object>> poolGroups = store.groups.get(poolId);
    if (poolGroups == null || !poolGroups.containsKey(groupName)) {
      throw new IllegalArgumentException(
          "ResourceNotFoundException: Group " + groupName + " not found");
    }
    return poolGroups.get(groupName);
  }

  static Map<String, Object> formatUser(Map<String, Object> user) {
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("Username", user.get("Username"));
    result.put("UserStatus", user.get("UserStatus"));
    result.put("Enabled", user.get("Enabled"));
    result.put("UserAttributes", user.get("UserAttributes"));
    result.put("UserCreateDate", user.get("UserCreateDate"));
    result.put("UserLastModifiedDate", user.get("UserLastModifiedDate"));
    return result;
  }

  static Map<String, Object> formatUserShort(Map<String, Object> user) {
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("Username", user.get("Username"));
    result.put("UserStatus", user.get("UserStatus"));
    result.put("Enabled", user.get("Enabled"));
    result.put("Attributes", user.get("UserAttributes"));
    result.put("UserCreateDate", user.get("UserCreateDate"));
    result.put("UserLastModifiedDate", user.get("UserLastModifiedDate"));
    return result;
  }

  static double nowSeconds() {
    return System.currentTimeMillis() / 1000.0;
  }

  static String uuid9() {
    return UUID.randomUUID().toString().replace("-", "").substring(0, 9);
  }

  static String uuid26() {
    return UUID.randomUUID().toString().replace("-", "").substring(0, 26);
  }

  void sendJson(HttpExchange exchange, int status, Object responseBody) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(responseBody);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
