package io.localwebservices.lws.providers.secretsmanager;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** SecretsManager wire-protocol HTTP handler. */
public class SecretsManagerHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String TARGET_PREFIX = "secretsmanager.";
  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final ServerState state;
  private final Map<String, Map<String, Object>> secrets = new ConcurrentHashMap<>();
  private final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

  public SecretsManagerHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(this::reset);
  }

  private void reset() {
    secrets.clear();
    resourceTags.clear();
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
      if (IamMiddleware.applyIamAuth(state, "secretsmanager", operation, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "secretsmanager", operation, exchange, false)) return;

      handleOperation(operation, body, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      sendJson(
          exchange,
          400,
          Map.of(
              "__type",
              "ResourceNotFoundException",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  private String secretArn(String name) {
    return "arn:aws:secretsmanager:" + REGION + ":" + ACCOUNT + ":secret:" + name;
  }

  @SuppressWarnings("unchecked")
  private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateSecret":
        {
          String name = (String) body.get("Name");
          Map<String, Object> existing = secrets.get(name);
          if (existing != null && existing.get("DeletedDate") == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceExistsException",
                    "message",
                    "A resource with the ID you requested already exists."));
            break;
          }
          String arn = secretArn(name);
          Map<String, Object> secret = new LinkedHashMap<>();
          secret.put("Name", name);
          secret.put("ARN", arn);
          secret.put("SecretString", body.get("SecretString"));
          secret.put("SecretBinary", body.get("SecretBinary"));
          secret.put("VersionId", UUID.randomUUID().toString());
          secret.put("CreatedDate", System.currentTimeMillis() / 1000.0);
          secret.put("DeletedDate", null);
          secret.put("Tags", body.getOrDefault("Tags", List.of()));
          secrets.put(name, secret);
          sendJson(
              exchange,
              200,
              Map.of("Name", name, "ARN", arn, "VersionId", secret.get("VersionId")));
          break;
        }
      case "GetSecretValue":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = findSecret(secretId);
          if (secret == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFoundException",
                    "message",
                    "Secret not found: " + secretId));
            return;
          }
          Map<String, Object> result = new LinkedHashMap<>();
          result.put("Name", secret.get("Name"));
          result.put("ARN", secret.get("ARN"));
          result.put("VersionId", secret.get("VersionId"));
          result.put("CreatedDate", secret.get("CreatedDate"));
          if (secret.get("SecretString") != null)
            result.put("SecretString", secret.get("SecretString"));
          if (secret.get("SecretBinary") != null)
            result.put("SecretBinary", secret.get("SecretBinary"));
          sendJson(exchange, 200, result);
          break;
        }
      case "PutSecretValue":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = findSecret(secretId);
          if (secret == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFoundException",
                    "message",
                    "Secret not found: " + secretId));
            return;
          }
          String versionId = UUID.randomUUID().toString();
          secret.put("SecretString", body.get("SecretString"));
          secret.put("SecretBinary", body.get("SecretBinary"));
          secret.put("VersionId", versionId);
          sendJson(
              exchange,
              200,
              Map.of("Name", secret.get("Name"), "ARN", secret.get("ARN"), "VersionId", versionId));
          break;
        }
      case "DescribeSecret":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = findSecret(secretId);
          if (secret == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFoundException",
                    "message",
                    "Secret not found: " + secretId));
            return;
          }
          Map<String, Object> result = new LinkedHashMap<>(secret);
          result.remove("SecretString");
          result.remove("SecretBinary");
          // Include tags
          String name = (String) secret.get("Name");
          List<Map<String, String>> tags = resourceTags.getOrDefault(name, List.of());
          if (!tags.isEmpty()) {
            result.put("Tags", tags);
          } else {
            result.put("Tags", List.of());
          }
          sendJson(exchange, 200, result);
          break;
        }
      case "UpdateSecret":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = findSecret(secretId);
          if (secret == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFoundException",
                    "message",
                    "Secret not found: " + secretId));
            return;
          }
          String versionId = UUID.randomUUID().toString();
          if (body.containsKey("SecretString"))
            secret.put("SecretString", body.get("SecretString"));
          if (body.containsKey("SecretBinary"))
            secret.put("SecretBinary", body.get("SecretBinary"));
          secret.put("VersionId", versionId);
          sendJson(
              exchange,
              200,
              Map.of("Name", secret.get("Name"), "ARN", secret.get("ARN"), "VersionId", versionId));
          break;
        }
      case "DeleteSecret":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = findSecret(secretId);
          if (secret == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFoundException",
                    "message",
                    "Secret not found: " + secretId));
            return;
          }
          boolean force = Boolean.TRUE.equals(body.get("ForceDeleteWithoutRecovery"));
          if (force) {
            secrets.remove((String) secret.get("Name"));
          } else {
            secret.put("DeletedDate", System.currentTimeMillis() / 1000.0);
          }
          sendJson(
              exchange,
              200,
              Map.of(
                  "Name",
                  secret.get("Name"),
                  "ARN",
                  secret.get("ARN"),
                  "DeletionDate",
                  System.currentTimeMillis() / 1000.0));
          break;
        }
      case "RestoreSecret":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = findSecret(secretId);
          if (secret == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFoundException",
                    "message",
                    "Secret not found: " + secretId));
            break;
          }
          if (secret.get("DeletedDate") == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "InvalidRequestException",
                    "message",
                    "Secret is not in a recoverable state."));
            break;
          }
          secret.remove("DeletedDate");
          sendJson(exchange, 200, Map.of("Name", secret.get("Name"), "ARN", secret.get("ARN")));
          break;
        }
      case "ListSecrets":
        {
          List<Map<String, Object>> list = new ArrayList<>();
          for (Map<String, Object> secret : secrets.values()) {
            Map<String, Object> entry = new LinkedHashMap<>();
            entry.put("Name", secret.get("Name"));
            entry.put("ARN", secret.get("ARN"));
            entry.put("CreatedDate", secret.get("CreatedDate"));
            if (secret.get("DeletedDate") != null)
              entry.put("DeletedDate", secret.get("DeletedDate"));
            list.add(entry);
          }
          sendJson(exchange, 200, Map.of("SecretList", list));
          break;
        }
      case "ListSecretVersionIds":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = findSecret(secretId);
          List<Map<String, Object>> versions = new ArrayList<>();
          if (secret != null) {
            versions.add(
                Map.of(
                    "VersionId", secret.get("VersionId"), "VersionStages", List.of("AWSCURRENT")));
          }
          sendJson(exchange, 200, Map.of("Versions", versions, "Name", secretId));
          break;
        }
      case "GetResourcePolicy":
        {
          sendJson(exchange, 200, Map.of("ResourcePolicy", ""));
          break;
        }
      case "TagResource":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = findSecret(secretId);
          if (secret == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFoundException",
                    "message",
                    "Secret not found: " + secretId));
            break;
          }
          List<Map<String, Object>> newTags =
              (List<Map<String, Object>>) body.getOrDefault("Tags", List.of());
          List<Map<String, String>> existing =
              resourceTags.computeIfAbsent(secretId, k -> new ArrayList<>());
          for (Map<String, Object> tag : newTags) {
            existing.add(
                Map.of("Key", (String) tag.get("Key"), "Value", (String) tag.get("Value")));
          }
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "UntagResource":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = findSecret(secretId);
          if (secret == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFoundException",
                    "message",
                    "Secret not found: " + secretId));
            break;
          }
          List<String> tagKeys = (List<String>) body.getOrDefault("TagKeys", List.of());
          List<Map<String, String>> existing =
              resourceTags.getOrDefault(secretId, new ArrayList<>());
          existing.removeIf(t -> tagKeys.contains(t.get("Key")));
          sendJson(exchange, 200, Map.of());
          break;
        }
      default:
        {
          sendJson(
              exchange,
              400,
              Map.of(
                  "__type",
                  "UnknownOperationException",
                  "message",
                  "Not implemented: " + operation));
        }
    }
  }

  private Map<String, Object> findSecret(String secretId) {
    // Try by name first
    if (secrets.containsKey(secretId)) return secrets.get(secretId);
    // Try by ARN
    for (Map<String, Object> secret : secrets.values()) {
      if (secretId.equals(secret.get("ARN"))) return secret;
    }
    return null;
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
