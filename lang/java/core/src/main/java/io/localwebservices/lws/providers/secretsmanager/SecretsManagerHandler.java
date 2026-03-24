package io.localwebservices.lws.providers.secretsmanager;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.util.*;

/** SecretsManager wire-protocol HTTP handler. */
public class SecretsManagerHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String TARGET_PREFIX = "secretsmanager.";

  private final ServerState state;
  private final SecretsManagerStore store;

  public SecretsManagerHandler(ServerState state) {
    this.state = state;
    this.store = new SecretsManagerStore();
    state.resetCallbacks.add(store::reset);
  }

  /**
   * Gets a secret value programmatically (used by StepFunctions service task bridges). The params
   * map must contain "SecretId". Returns a map with the secret fields.
   */
  public Map<String, Object> executeGetSecretValue(Map<String, Object> params) {
    String secretId = (String) params.get("SecretId");
    Map<String, Object> secret = store.findSecret(secretId);
    if (secret == null) {
      throw new RuntimeException("ResourceNotFoundException: Secret not found: " + secretId);
    }
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("Name", secret.get("Name"));
    result.put("ARN", secret.get("ARN"));
    result.put("VersionId", secret.get("VersionId"));
    result.put("CreatedDate", secret.get("CreatedDate"));
    if (secret.get("SecretString") != null) result.put("SecretString", secret.get("SecretString"));
    if (secret.get("SecretBinary") != null) result.put("SecretBinary", secret.get("SecretBinary"));
    return result;
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

  @SuppressWarnings("unchecked")
  private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateSecret":
        {
          String name = (String) body.get("Name");
          if (store.secretExists(name)) {
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
          Map<String, Object> secret =
              store.createSecret(
                  name, body.get("SecretString"), body.get("SecretBinary"), body.get("Tags"));
          sendJson(
              exchange,
              200,
              Map.of("Name", name, "ARN", secret.get("ARN"), "VersionId", secret.get("VersionId")));
          break;
        }
      case "GetSecretValue":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = store.findSecret(secretId);
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
          Map<String, Object> secret = store.findSecret(secretId);
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
          store.putSecretValue(secret, body.get("SecretString"), body.get("SecretBinary"));
          sendJson(
              exchange,
              200,
              Map.of(
                  "Name",
                  secret.get("Name"),
                  "ARN",
                  secret.get("ARN"),
                  "VersionId",
                  secret.get("VersionId")));
          break;
        }
      case "DescribeSecret":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = store.findSecret(secretId);
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
          String name = (String) secret.get("Name");
          List<Map<String, String>> tags = store.listTags(name);
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
          Map<String, Object> secret = store.findSecret(secretId);
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
          Object secretString =
              body.containsKey("SecretString")
                  ? body.get("SecretString")
                  : secret.get("SecretString");
          Object secretBinary =
              body.containsKey("SecretBinary")
                  ? body.get("SecretBinary")
                  : secret.get("SecretBinary");
          store.updateSecret(secret, secretString, secretBinary, versionId);
          sendJson(
              exchange,
              200,
              Map.of("Name", secret.get("Name"), "ARN", secret.get("ARN"), "VersionId", versionId));
          break;
        }
      case "DeleteSecret":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = store.findSecret(secretId);
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
          String secretName = (String) secret.get("Name");
          store.deleteSecret(secretName, force);
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
          Map<String, Object> secret = store.findSecret(secretId);
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
          store.restoreSecret(secret);
          sendJson(exchange, 200, Map.of("Name", secret.get("Name"), "ARN", secret.get("ARN")));
          break;
        }
      case "ListSecrets":
        {
          List<Map<String, Object>> list = store.listSecrets();
          sendJson(exchange, 200, Map.of("SecretList", list));
          break;
        }
      case "ListSecretVersionIds":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = store.findSecret(secretId);
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
          Map<String, Object> secret = store.findSecret(secretId);
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
          store.tagResource(secretId, newTags);
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "UntagResource":
        {
          String secretId = (String) body.get("SecretId");
          Map<String, Object> secret = store.findSecret(secretId);
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
          store.untagResource(secretId, tagKeys);
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

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
