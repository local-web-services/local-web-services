package io.localwebservices.lws.providers.sqs;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

/** SQS wire-protocol HTTP handler. */
public class SqsHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private final ServerState state;
  private final SqsStore store;

  private final SqsFormActions formActions;

  public SqsHandler(ServerState state, int port) {
    this.state = state;
    this.store = new SqsStore(port);
    this.formActions = new SqsFormActions(store);
    state.resetCallbacks.add(store::reset);
  }

  /**
   * Sends a message to a queue programmatically (used by StepFunctions service task bridges). The
   * params map must contain "QueueUrl" and "MessageBody" keys. Returns a map with "MessageId".
   */
  public Map<String, Object> executeSendMessage(Map<String, Object> params) {
    String queueUrl = (String) params.get("QueueUrl");
    String messageBody = (String) params.get("MessageBody");
    int delay =
        params.get("DelaySeconds") != null ? ((Number) params.get("DelaySeconds")).intValue() : 0;
    SqsStore.LocalQueue q = store.getQueue(queueUrl);
    if (q == null) {
      throw new RuntimeException("Queue not found: " + queueUrl);
    }
    String msgId = q.sendMessage(messageBody, delay);
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("MessageId", msgId);
    result.put("MD5OfMessageBody", SqsStore.md5(messageBody));
    return result;
  }

  /**
   * Delivers a message body directly to the named queue. Used for cross-service delivery (e.g.
   * SNS→SQS, EventBridge→SQS). Does nothing if the queue does not exist.
   */
  public void deliverToQueue(String queueNameOrUrl, String messageBody) {
    SqsStore.LocalQueue q = store.getQueue(queueNameOrUrl);
    if (q != null) {
      q.sendMessage(messageBody, 0);
    }
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    try (InputStream is = exchange.getRequestBody()) {
      byte[] bodyBytes = is.readAllBytes();
      String contentType = exchange.getRequestHeaders().getFirst("Content-Type");
      if (contentType == null) contentType = "";
      String amzTarget = exchange.getRequestHeaders().getFirst("X-Amz-Target");

      // Determine if JSON protocol
      boolean isJson = contentType.contains("application/x-amz-json") || amzTarget != null;

      Map<String, String> formParams = new LinkedHashMap<>();
      Map<String, Object> jsonBody = null;

      if (isJson) {
        if (bodyBytes.length > 0) {
          jsonBody = MAPPER.readValue(bodyBytes, Map.class);
        } else {
          jsonBody = Map.of();
        }
      } else {
        // Form-encoded
        String bodyStr = new String(bodyBytes, StandardCharsets.UTF_8);
        for (String pair : bodyStr.split("&")) {
          if (pair.isEmpty()) continue;
          String[] kv = pair.split("=", 2);
          String k = URLDecoder.decode(kv[0], StandardCharsets.UTF_8);
          String v = kv.length > 1 ? URLDecoder.decode(kv[1], StandardCharsets.UTF_8) : "";
          formParams.put(k, v);
        }
      }

      // Determine action
      String action = "";
      if (amzTarget != null) {
        action =
            amzTarget.contains(".")
                ? amzTarget.substring(amzTarget.lastIndexOf('.') + 1)
                : amzTarget;
      } else if (jsonBody != null && jsonBody.containsKey("Action")) {
        action = (String) jsonBody.get("Action");
      } else if (formParams.containsKey("Action")) {
        action = formParams.get("Action");
      }

      try {
        if (IamMiddleware.applyIamAuth(state, "sqs", action, exchange, !isJson)) return;
        if (ChaosMiddleware.applyChaos(state, "sqs", action, exchange, !isJson)) return;
        if ("SendMessage".equals(action)
            && state.getCapacityConfig("sqs").isExhausted()
            && !isJson) {
          sendError(
              exchange,
              "AWS.SimpleQueueService.QueueDeletedRecently",
              "The queue does not have enough capacity.",
              false,
              400);
          return;
        }

        if (isJson) {
          handleJsonAction(action, jsonBody, exchange.getRequestURI().getPath(), exchange);
        } else {
          formActions.handle(action, formParams, exchange.getRequestURI().getPath(), exchange);
        }
      } catch (InterruptedException e) {
        Thread.currentThread().interrupt();
        sendError(exchange, "ServiceUnavailable", "Interrupted", isJson, 500);
      } catch (Exception e) {
        sendError(
            exchange,
            "AWS.SimpleQueueService.NonExistentQueue",
            e.getMessage() != null ? e.getMessage() : "Error",
            isJson,
            400);
      }
    }
  }

  @SuppressWarnings("unchecked")
  private void handleJsonAction(
      String action, Map<String, Object> body, String path, HttpExchange exchange)
      throws IOException {
    switch (action) {
      case "CreateQueue":
        {
          String name = (String) body.get("QueueName");
          Map<String, String> attrs =
              (Map<String, String>) body.getOrDefault("Attributes", Map.of());
          if (store.getQueue(name) != null) {
            sendError(
                exchange,
                "QueueAlreadyExists",
                "A queue already exists with the same name",
                true,
                400);
            break;
          }
          SqsStore.LocalQueue q = store.createQueue(name, attrs);
          sendJsonResponse(exchange, Map.of("QueueUrl", q.url));
          break;
        }
      case "GetQueueUrl":
        {
          String name = (String) body.get("QueueName");
          if (store.getQueue(name) == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "The specified queue does not exist.",
                true,
                400);
            break;
          }
          sendJsonResponse(exchange, Map.of("QueueUrl", store.queueUrl(name)));
          break;
        }
      case "ListQueues":
        {
          String prefix = (String) body.get("QueueNamePrefix");
          List<SqsStore.LocalQueue> queues = store.listQueues(prefix);
          List<String> urls = new ArrayList<>();
          for (SqsStore.LocalQueue q : queues) urls.add(q.url);
          sendJsonResponse(exchange, Map.of("QueueUrls", urls));
          break;
        }
      case "DeleteQueue":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          if (store.getQueue(queueUrl) == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "Queue does not exist.",
                true,
                400);
            break;
          }
          store.deleteQueue(queueUrl);
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "SendMessage":
        {
          if (state.getCapacityConfig("sqs").isExhausted()) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.QueueDeletedRecently",
                "The queue does not have enough capacity.",
                true,
                400);
            break;
          }
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "Queue not found: " + queueUrl,
                true,
                400);
            return;
          }
          String msgBody = (String) body.get("MessageBody");
          int delay =
              body.get("DelaySeconds") != null ? ((Number) body.get("DelaySeconds")).intValue() : 0;
          String msgId = q.sendMessage(msgBody, delay);
          sendJsonResponse(
              exchange, Map.of("MessageId", msgId, "MD5OfMessageBody", SqsStore.md5(msgBody)));
          break;
        }
      case "SendMessageBatch":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", true, 400);
            return;
          }
          List<Map<String, Object>> entries =
              (List<Map<String, Object>>) body.getOrDefault("Entries", List.of());
          List<Map<String, Object>> successful = new ArrayList<>();
          for (Map<String, Object> entry : entries) {
            String msgBody = (String) entry.get("MessageBody");
            int delay =
                entry.get("DelaySeconds") != null
                    ? ((Number) entry.get("DelaySeconds")).intValue()
                    : 0;
            String msgId = q.sendMessage(msgBody != null ? msgBody : "", delay);
            successful.add(
                Map.of(
                    "Id",
                    entry.get("Id"),
                    "MessageId",
                    msgId,
                    "MD5OfMessageBody",
                    SqsStore.md5(msgBody != null ? msgBody : "")));
          }
          sendJsonResponse(exchange, Map.of("Successful", successful, "Failed", List.of()));
          break;
        }
      case "ReceiveMessage":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", true, 400);
            return;
          }
          int maxMessages =
              body.get("MaxNumberOfMessages") != null
                  ? ((Number) body.get("MaxNumberOfMessages")).intValue()
                  : 1;
          List<SqsStore.SqsMessage> msgs = q.receiveMessages(maxMessages);
          List<Map<String, Object>> result = new ArrayList<>();
          for (SqsStore.SqsMessage msg : msgs) {
            result.add(
                Map.of(
                    "MessageId",
                    msg.messageId,
                    "ReceiptHandle",
                    msg.receiptHandle,
                    "MD5OfBody",
                    SqsStore.md5(msg.body),
                    "Body",
                    msg.body,
                    "Attributes",
                    msg.attributes));
          }
          sendJsonResponse(exchange, Map.of("Messages", result));
          break;
        }
      case "DeleteMessage":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "Queue does not exist.",
                true,
                400);
            return;
          }
          String receiptHandle = (String) body.get("ReceiptHandle");
          if (!q.hasMessage(receiptHandle)) {
            sendError(exchange, "ReceiptHandleIsInvalid", "Invalid receipt handle.", true, 400);
            return;
          }
          q.deleteMessage(receiptHandle);
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "DeleteMessageBatch":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          List<Map<String, Object>> entries =
              (List<Map<String, Object>>) body.getOrDefault("Entries", List.of());
          List<Map<String, Object>> successful = new ArrayList<>();
          for (Map<String, Object> entry : entries) {
            if (q != null) q.deleteMessage((String) entry.get("ReceiptHandle"));
            successful.add(Map.of("Id", entry.get("Id")));
          }
          sendJsonResponse(exchange, Map.of("Successful", successful, "Failed", List.of()));
          break;
        }
      case "PurgeQueue":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "Queue does not exist.",
                true,
                400);
            return;
          }
          q.purge();
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "GetQueueAttributes":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", true, 400);
            return;
          }
          Map<String, String> attrs = buildQueueAttributes(q);
          sendJsonResponse(exchange, Map.of("Attributes", attrs));
          break;
        }
      case "SetQueueAttributes":
        {
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "ChangeMessageVisibility":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "Queue does not exist.",
                true,
                400);
            return;
          }
          String receiptHandle = (String) body.get("ReceiptHandle");
          if (!q.hasMessage(receiptHandle)) {
            sendError(exchange, "ReceiptHandleIsInvalid", "Invalid receipt handle.", true, 400);
            return;
          }
          int timeout =
              body.get("VisibilityTimeout") != null
                  ? ((Number) body.get("VisibilityTimeout")).intValue()
                  : 0;
          q.changeVisibility(receiptHandle, timeout);
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "ChangeMessageVisibilityBatch":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          List<Map<String, Object>> entries =
              (List<Map<String, Object>>) body.getOrDefault("Entries", List.of());
          List<Map<String, Object>> successful = new ArrayList<>();
          for (Map<String, Object> entry : entries) {
            if (q != null) {
              int timeout =
                  entry.get("VisibilityTimeout") != null
                      ? ((Number) entry.get("VisibilityTimeout")).intValue()
                      : 0;
              q.changeVisibility((String) entry.get("ReceiptHandle"), timeout);
            }
            successful.add(Map.of("Id", entry.get("Id")));
          }
          sendJsonResponse(exchange, Map.of("Successful", successful, "Failed", List.of()));
          break;
        }
      case "ListQueueTags":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          sendJsonResponse(exchange, Map.of("Tags", store.getQueueTags(queueUrl)));
          break;
        }
      case "TagQueue":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          Map<String, String> tags = (Map<String, String>) body.getOrDefault("Tags", Map.of());
          store.setQueueTags(queueUrl, tags);
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "UntagQueue":
        {
          String queueUrl = (String) body.get("QueueUrl");
          if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
          List<String> tagKeys = (List<String>) body.getOrDefault("TagKeys", List.of());
          store.removeQueueTags(queueUrl, tagKeys);
          sendJsonResponse(exchange, Map.of());
          break;
        }
      case "ListDeadLetterSourceQueues":
        {
          sendJsonResponse(exchange, Map.of("queueUrls", List.of()));
          break;
        }
      default:
        {
          sendError(exchange, "InvalidAction", "Unknown action: " + action, true, 400);
        }
    }
  }

  private Map<String, String> buildQueueAttributes(SqsStore.LocalQueue q) {
    return formActions.buildQueueAttributes(q);
  }

  private String extractQueueUrlFromPath(String path) {
    return "http://127.0.0.1" + path;
  }

  private void sendJsonResponse(HttpExchange exchange, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.0");
    exchange.sendResponseHeaders(200, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }

  private void sendError(HttpExchange exchange, String code, String msg, boolean isJson, int status)
      throws IOException {
    formActions.sendError(exchange, code, msg, isJson, status);
  }
}
