package io.localwebservices.lws.providers.opensearch;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** OpenSearch wire-protocol HTTP handler (JSON, X-Amz-Target). */
public class OpenSearchHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String TARGET_PREFIX = "OpenSearch_20210101.";
  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final ServerState state;
  private final Map<String, Map<String, Object>> domains = new ConcurrentHashMap<>();
  private final Map<String, List<Map<String, String>>> domainTags = new ConcurrentHashMap<>();

  public OpenSearchHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(this::reset);
  }

  private void reset() {
    domains.clear();
    domainTags.clear();
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
      if (IamMiddleware.applyIamAuth(state, "opensearch", operation, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "opensearch", operation, exchange, false)) return;

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
      case "CreateDomain":
        {
          String name = (String) body.get("DomainName");
          Map<String, Object> domain = buildDomain(name);
          domains.put(name, domain);
          sendJson(exchange, 200, Map.of("DomainStatus", domain));
          break;
        }
      case "DeleteDomain":
        {
          String name = (String) body.get("DomainName");
          Map<String, Object> domain = domains.remove(name);
          if (domain == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ResourceNotFoundException", "message", "Domain not found: " + name));
            return;
          }
          sendJson(exchange, 200, Map.of("DomainStatus", domain));
          break;
        }
      case "DescribeDomain":
        {
          String name = (String) body.get("DomainName");
          Map<String, Object> domain = domains.get(name);
          if (domain == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ResourceNotFoundException", "message", "Domain not found: " + name));
            return;
          }
          sendJson(exchange, 200, Map.of("DomainStatus", domain));
          break;
        }
      case "ListDomainNames":
        {
          List<Map<String, Object>> list = new ArrayList<>();
          for (String name : domains.keySet()) {
            list.add(Map.of("DomainName", name));
          }
          sendJson(exchange, 200, Map.of("DomainNames", list));
          break;
        }
      case "AddTags":
        {
          String arn = (String) body.get("ARN");
          String domainName = arnToDomainName(arn);
          List<Map<String, Object>> newTags =
              (List<Map<String, Object>>) body.getOrDefault("TagList", List.of());
          List<Map<String, String>> existing =
              domainTags.computeIfAbsent(domainName, k -> new ArrayList<>());
          for (Map<String, Object> tag : newTags) {
            existing.add(
                Map.of("Key", (String) tag.get("Key"), "Value", (String) tag.get("Value")));
          }
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "ListTags":
        {
          String arn = (String) body.get("ARN");
          String domainName = arnToDomainName(arn);
          List<Map<String, String>> tags = domainTags.getOrDefault(domainName, List.of());
          sendJson(exchange, 200, Map.of("TagList", tags));
          break;
        }
      case "RemoveTags":
        {
          String arn = (String) body.get("ARN");
          String domainName = arnToDomainName(arn);
          List<String> tagKeys = (List<String>) body.getOrDefault("TagKeys", List.of());
          List<Map<String, String>> existing =
              domainTags.getOrDefault(domainName, new ArrayList<>());
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

  private Map<String, Object> buildDomain(String name) {
    Map<String, Object> domain = new LinkedHashMap<>();
    domain.put("DomainId", ACCOUNT + "/" + name);
    domain.put("DomainName", name);
    domain.put("ARN", "arn:aws:opensearch:" + REGION + ":" + ACCOUNT + ":domain/" + name);
    domain.put("Created", true);
    domain.put("Deleted", false);
    domain.put("Processing", false);
    domain.put("Endpoint", "http://localhost:9200");
    domain.put("EngineType", "OpenSearch");
    domain.put("EBSOptions", Map.of("EBSEnabled", false));
    return domain;
  }

  private String arnToDomainName(String arn) {
    if (arn == null) return "";
    String[] parts = arn.split("/");
    return parts.length > 1 ? parts[parts.length - 1] : arn;
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/json");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
