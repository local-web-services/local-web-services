package io.localwebservices.lws.providers.sns;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

/** SNS wire-protocol HTTP handler. */
public class SnsHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final ServerState state;
  private final SnsStore store = new SnsStore();
  private final SnsFormActions formActions = new SnsFormActions(store);

  public SnsHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(store::reset);
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }
    String contentType = exchange.getRequestHeaders().getFirst("Content-Type");
    if (contentType == null) contentType = "";
    String amzTarget = exchange.getRequestHeaders().getFirst("X-Amz-Target");

    boolean isJson = contentType.contains("application/x-amz-json") || amzTarget != null;

    Map<String, String> formParams = new LinkedHashMap<>();
    Map<String, Object> jsonBody = null;
    String action = "";

    if (isJson) {
      jsonBody =
          bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
      if (amzTarget != null)
        action =
            amzTarget.contains(".")
                ? amzTarget.substring(amzTarget.lastIndexOf('.') + 1)
                : amzTarget;
    } else {
      String bodyStr = new String(bodyBytes, StandardCharsets.UTF_8);
      for (String pair : bodyStr.split("&")) {
        if (pair.isEmpty()) continue;
        String[] kv = pair.split("=", 2);
        formParams.put(
            URLDecoder.decode(kv[0], StandardCharsets.UTF_8),
            kv.length > 1 ? URLDecoder.decode(kv[1], StandardCharsets.UTF_8) : "");
      }
      action = formParams.getOrDefault("Action", "");
    }

    try {
      if (IamMiddleware.applyIamAuth(state, "sns", action, exchange, !isJson)) return;
      if (ChaosMiddleware.applyChaos(state, "sns", action, exchange, !isJson)) return;

      if (isJson) {
        handleJsonAction(action, jsonBody, exchange);
      } else {
        formActions.handle(action, formParams, exchange);
      }
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendError(exchange, "ServiceUnavailable", "Interrupted", isJson, 500);
    } catch (Exception e) {
      sendError(
          exchange,
          "InternalError",
          e.getMessage() != null ? e.getMessage() : "Error",
          isJson,
          400);
    }
  }

  @SuppressWarnings("unchecked")
  private void handleJsonAction(String action, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (action) {
      case "CreateTopic":
        {
          String name = (String) body.get("Name");
          String arn = store.topicArn(name);
          if (store.topics.containsKey(arn)) {
            sendError(exchange, "TopicLimitExceeded", "Topic already exists", true, 400);
            break;
          }
          store.topics.put(arn, new LinkedHashMap<>(Map.of("TopicArn", arn, "DisplayName", name)));
          sendJsonResponse(exchange, Map.of("TopicArn", arn));
          break;
        }
      case "DeleteTopic":
        {
          String arn = (String) body.get("TopicArn");
          if (!store.topics.containsKey(arn)) {
            sendError(exchange, "NotFound", "Topic not found: " + arn, true, 400);
            break;
          }
          store.topics.remove(arn);
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "ListTopics":
        {
          List<Map<String, Object>> list = new ArrayList<>();
          for (String arn : store.topics.keySet()) list.add(Map.of("TopicArn", arn));
          sendJsonResponse(exchange, Map.of("Topics", list));
          break;
        }
      case "Publish":
        {
          String publishTopicArn = (String) body.get("TopicArn");
          if (publishTopicArn == null || !store.topics.containsKey(publishTopicArn)) {
            sendError(exchange, "NotFound", "Topic not found: " + publishTopicArn, true, 400);
            break;
          }
          // Check if any subscription exists for this topic
          boolean hasSubscription =
              store.subscriptions.values().stream()
                  .anyMatch(sub -> publishTopicArn.equals(sub.get("TopicArn")));
          if (!hasSubscription) {
            sendError(
                exchange,
                "InvalidParameter",
                "No confirmed store.subscriptions for topic: " + publishTopicArn,
                true,
                400);
            break;
          }
          String msgId = UUID.randomUUID().toString();
          sendJsonResponse(exchange, Map.of("MessageId", msgId));
          break;
        }
      case "Subscribe":
        {
          String topicArn = (String) body.get("TopicArn");
          if (topicArn == null || !store.topics.containsKey(topicArn)) {
            sendError(exchange, "NotFound", "Topic not found: " + topicArn, true, 400);
            break;
          }
          String arn = UUID.randomUUID().toString();
          Map<String, Object> sub = new LinkedHashMap<>(body);
          sub.put("SubscriptionArn", arn);
          store.subscriptions.put(arn, sub);
          sendJsonResponse(exchange, Map.of("SubscriptionArn", arn));
          break;
        }
      case "Unsubscribe":
        {
          String arn = (String) body.get("SubscriptionArn");
          if (!store.subscriptions.containsKey(arn)) {
            sendError(exchange, "NotFound", "Subscription not found: " + arn, true, 400);
            break;
          }
          store.subscriptions.remove(arn);
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "ListSubscriptions":
        {
          List<Map<String, Object>> list = new ArrayList<>(store.subscriptions.values());
          sendJsonResponse(exchange, Map.of("Subscriptions", list));
          break;
        }
      case "ListSubscriptionsByTopic":
        {
          String topicArn = (String) body.get("TopicArn");
          List<Map<String, Object>> list = new ArrayList<>();
          for (Map<String, Object> sub : store.subscriptions.values()) {
            if (topicArn.equals(sub.get("TopicArn"))) list.add(sub);
          }
          sendJsonResponse(exchange, Map.of("Subscriptions", list));
          break;
        }
      case "GetTopicAttributes":
        {
          String arn = (String) body.get("TopicArn");
          Map<String, Object> topic = store.topics.getOrDefault(arn, Map.of());
          Map<String, String> attrs = new LinkedHashMap<>();
          attrs.put("TopicArn", arn);
          // Copy all stored string attributes
          for (Map.Entry<String, Object> e : topic.entrySet()) {
            if (e.getValue() instanceof String) attrs.put(e.getKey(), (String) e.getValue());
          }
          if (!attrs.containsKey("DisplayName")) attrs.put("DisplayName", "");
          attrs.put("SubscriptionsConfirmed", "0");
          attrs.put("SubscriptionsPending", "0");
          sendJsonResponse(exchange, Map.of("Attributes", attrs));
          break;
        }
      case "SetTopicAttributes":
        {
          String topicArn = (String) body.get("TopicArn");
          String attrName = (String) body.get("AttributeName");
          String attrValue = (String) body.get("AttributeValue");
          Map<String, Object> topic = store.topics.get(topicArn);
          if (topic != null && attrName != null)
            topic.put(attrName, attrValue != null ? attrValue : "");
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "GetSubscriptionAttributes":
        {
          String subArn = (String) body.get("SubscriptionArn");
          Map<String, String> attrs =
              store.subscriptionAttrs.getOrDefault(subArn, new LinkedHashMap<>());
          Map<String, Object> sub = store.subscriptions.get(subArn);
          if (sub != null) {
            attrs = new LinkedHashMap<>(attrs);
            attrs.put("SubscriptionArn", subArn);
            if (sub.get("Protocol") != null) attrs.put("Protocol", (String) sub.get("Protocol"));
            if (sub.get("Endpoint") != null) attrs.put("Endpoint", (String) sub.get("Endpoint"));
            if (sub.get("TopicArn") != null) attrs.put("TopicArn", (String) sub.get("TopicArn"));
          }
          sendJsonResponse(exchange, Map.of("Attributes", attrs));
          break;
        }
      case "SetSubscriptionAttributes":
        {
          String subArn = (String) body.get("SubscriptionArn");
          String attrName = (String) body.get("AttributeName");
          String attrValue = (String) body.get("AttributeValue");
          if (attrName != null) {
            store
                .subscriptionAttrs
                .computeIfAbsent(subArn, k -> new LinkedHashMap<>())
                .put(attrName, attrValue != null ? attrValue : "");
          }
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "ConfirmSubscription":
        {
          sendJsonResponse(exchange, Map.of("SubscriptionArn", UUID.randomUUID().toString()));
          break;
        }
      case "ListTagsForResource":
        {
          String resourceArn = (String) body.get("ResourceArn");
          List<Map<String, String>> tags = store.resourceTags.getOrDefault(resourceArn, List.of());
          sendJsonResponse(exchange, Map.of("Tags", tags));
          break;
        }
      case "TagResource":
        {
          String resourceArn = (String) body.get("ResourceArn");
          List<Map<String, Object>> newTags =
              (List<Map<String, Object>>) body.getOrDefault("Tags", List.of());
          List<Map<String, String>> existing =
              store.resourceTags.computeIfAbsent(resourceArn, k -> new ArrayList<>());
          for (Map<String, Object> tag : newTags) {
            existing.add(
                Map.of("Key", (String) tag.get("Key"), "Value", (String) tag.get("Value")));
          }
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "UntagResource":
        {
          String resourceArn = (String) body.get("ResourceArn");
          List<String> tagKeys = (List<String>) body.getOrDefault("TagKeys", List.of());
          List<Map<String, String>> existing =
              store.resourceTags.getOrDefault(resourceArn, new ArrayList<>());
          existing.removeIf(t -> tagKeys.contains(t.get("Key")));
          sendJsonResponse(exchange, Map.of());
          break;
        }
      default:
        sendError(exchange, "InvalidAction", "Unknown: " + action, true, 400);
    }
  }

  private void sendJsonResponse(HttpExchange exchange, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.0");
    exchange.sendResponseHeaders(200, bytes.length);
    try (java.io.OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }

  private void sendError(HttpExchange exchange, String code, String msg, boolean isJson, int status)
      throws IOException {
    formActions.sendError(exchange, code, msg, isJson, status);
  }
}
