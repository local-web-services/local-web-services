package io.localwebservices.lws.providers.sqs;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/** Handles SQS form-encoded (query protocol) actions. */
class SqsFormActions {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String ACCOUNT_ID = "000000000000";

  private final SqsStore store;

  SqsFormActions(SqsStore store) {
    this.store = store;
  }

  void handle(String action, Map<String, String> params, String path, HttpExchange exchange)
      throws IOException {
    Map<String, String> attrs = new LinkedHashMap<>();
    for (int i = 1; i <= 20; i++) {
      String name = params.get("Attribute." + i + ".Name");
      String val = params.get("Attribute." + i + ".Value");
      if (name != null) attrs.put(name, val);
    }
    Map<String, String> tags = new LinkedHashMap<>();
    for (int i = 1; i <= 20; i++) {
      String key = params.get("Tag." + i + ".Key");
      String val = params.get("Tag." + i + ".Value");
      if (key != null) tags.put(key, val);
    }
    List<String> tagKeys = new ArrayList<>();
    for (int i = 1; i <= 20; i++) {
      String key = params.get("TagKey." + i);
      if (key != null) tagKeys.add(key);
    }

    switch (action) {
      case "CreateQueue":
        {
          String name = params.get("QueueName");
          if (store.getQueue(name) != null) {
            sendError(
                exchange,
                "QueueAlreadyExists",
                "A queue already exists with the same name",
                false,
                400);
            break;
          }
          SqsStore.LocalQueue q =
              store.createQueue(name, attrs.isEmpty() ? new LinkedHashMap<>() : attrs);
          sendXmlResponse(exchange, SqsXmlBuilder.createQueueXml(q.url));
          break;
        }
      case "GetQueueUrl":
        {
          String name = params.get("QueueName");
          sendXmlResponse(exchange, SqsXmlBuilder.getQueueUrlXml(store.queueUrl(name)));
          break;
        }
      case "ListQueues":
        {
          String prefix = params.get("QueueNamePrefix");
          List<SqsStore.LocalQueue> queues = store.listQueues(prefix);
          List<String> urls = new ArrayList<>();
          for (SqsStore.LocalQueue q : queues) urls.add(q.url);
          sendXmlResponse(exchange, SqsXmlBuilder.listQueuesXml(urls));
          break;
        }
      case "DeleteQueue":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          if (store.getQueue(queueUrl) == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "Queue does not exist.",
                false,
                400);
            break;
          }
          store.deleteQueue(queueUrl);
          sendXmlResponse(exchange, SqsXmlBuilder.simpleResponseXml("DeleteQueue"));
          break;
        }
      case "SendMessage":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", false, 400);
            return;
          }
          String msgBody = params.getOrDefault("MessageBody", "");
          int delay = Integer.parseInt(params.getOrDefault("DelaySeconds", "0"));
          String msgId = q.sendMessage(msgBody, delay);
          sendXmlResponse(exchange, SqsXmlBuilder.sendMessageXml(msgId, SqsStore.md5(msgBody)));
          break;
        }
      case "ReceiveMessage":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", false, 400);
            return;
          }
          int maxMessages = Integer.parseInt(params.getOrDefault("MaxNumberOfMessages", "1"));
          List<SqsStore.SqsMessage> msgs = q.receiveMessages(maxMessages);
          sendXmlResponse(exchange, SqsXmlBuilder.receiveMessageXml(msgs));
          break;
        }
      case "DeleteMessage":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "Queue does not exist.",
                false,
                400);
            return;
          }
          String receiptHandle = params.get("ReceiptHandle");
          if (!q.hasMessage(receiptHandle)) {
            sendError(exchange, "ReceiptHandleIsInvalid", "Invalid receipt handle.", false, 400);
            return;
          }
          q.deleteMessage(receiptHandle);
          sendXmlResponse(exchange, SqsXmlBuilder.simpleResponseXml("DeleteMessage"));
          break;
        }
      case "PurgeQueue":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "Queue does not exist.",
                false,
                400);
            return;
          }
          q.purge();
          sendXmlResponse(exchange, SqsXmlBuilder.simpleResponseXml("PurgeQueue"));
          break;
        }
      case "GetQueueAttributes":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", false, 400);
            return;
          }
          Map<String, String> qAttrs = buildQueueAttributes(q);
          sendXmlResponse(exchange, SqsXmlBuilder.getQueueAttributesXml(qAttrs));
          break;
        }
      case "SetQueueAttributes":
        {
          sendXmlResponse(exchange, SqsXmlBuilder.simpleResponseXml("SetQueueAttributes"));
          break;
        }
      case "ListQueueTags":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          Map<String, String> qTags = store.getQueueTags(queueUrl);
          sendXmlResponse(exchange, SqsXmlBuilder.listQueueTagsXml(qTags));
          break;
        }
      case "TagQueue":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          store.setQueueTags(queueUrl, tags);
          sendXmlResponse(exchange, SqsXmlBuilder.simpleResponseXml("TagQueue"));
          break;
        }
      case "UntagQueue":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          store.removeQueueTags(queueUrl, tagKeys);
          sendXmlResponse(exchange, SqsXmlBuilder.simpleResponseXml("UntagQueue"));
          break;
        }
      case "ChangeMessageVisibility":
        {
          String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
          SqsStore.LocalQueue q = store.getQueue(queueUrl);
          if (q == null) {
            sendError(
                exchange,
                "AWS.SimpleQueueService.NonExistentQueue",
                "Queue does not exist.",
                false,
                400);
            return;
          }
          String receiptHandle = params.get("ReceiptHandle");
          if (!q.hasMessage(receiptHandle)) {
            sendError(exchange, "ReceiptHandleIsInvalid", "Invalid receipt handle.", false, 400);
            return;
          }
          int timeout = Integer.parseInt(params.getOrDefault("VisibilityTimeout", "0"));
          q.changeVisibility(receiptHandle, timeout);
          sendXmlResponse(exchange, SqsXmlBuilder.simpleResponseXml("ChangeMessageVisibility"));
          break;
        }
      case "ChangeMessageVisibilityBatch":
      case "DeleteMessageBatch":
      case "SendMessageBatch":
      case "ListDeadLetterSourceQueues":
      case "AddPermission":
      case "RemovePermission":
        {
          sendXmlResponse(exchange, SqsXmlBuilder.simpleResponseXml(action));
          break;
        }
      default:
        {
          sendError(exchange, "InvalidAction", "Unknown action: " + action, false, 400);
        }
    }
  }

  Map<String, String> buildQueueAttributes(SqsStore.LocalQueue q) {
    Map<String, String> qAttrs = new LinkedHashMap<>();
    qAttrs.put("QueueArn", "arn:aws:sqs:us-east-1:" + ACCOUNT_ID + ":" + q.name);
    qAttrs.put("ApproximateNumberOfMessages", String.valueOf(q.approximateMessageCount()));
    qAttrs.put("ApproximateNumberOfMessagesNotVisible", String.valueOf(q.approximateNotVisibleCount()));
    qAttrs.put("VisibilityTimeout", String.valueOf(q.visibilityTimeout));
    qAttrs.put("CreatedTimestamp", String.valueOf(System.currentTimeMillis() / 1000));
    qAttrs.put("LastModifiedTimestamp", String.valueOf(System.currentTimeMillis() / 1000));
    qAttrs.put("FifoQueue", String.valueOf(q.isFifo));
    return qAttrs;
  }

  private String extractQueueUrlFromPath(String path) {
    return "http://127.0.0.1" + path;
  }

  void sendError(HttpExchange exchange, String code, String msg, boolean isJson, int status)
      throws IOException {
    if (isJson) {
      byte[] bytes = MAPPER.writeValueAsBytes(Map.of("__type", code, "message", msg));
      exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.0");
      exchange.sendResponseHeaders(status, bytes.length);
      try (OutputStream os = exchange.getResponseBody()) {
        os.write(bytes);
      }
    } else {
      String xml =
          "<?xml version=\"1.0\"?><ErrorResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">"
              + "<Error><Type>Sender</Type><Code>"
              + code
              + "</Code><Message>"
              + msg
              + "</Message></Error>"
              + "<RequestId>00000000-0000-0000-0000-000000000000</RequestId></ErrorResponse>";
      byte[] bytes = xml.getBytes(java.nio.charset.StandardCharsets.UTF_8);
      exchange.getResponseHeaders().set("Content-Type", "text/xml");
      exchange.sendResponseHeaders(status, bytes.length);
      try (OutputStream os = exchange.getResponseBody()) {
        os.write(bytes);
      }
    }
  }

  private void sendXmlResponse(HttpExchange exchange, String xml) throws IOException {
    byte[] bytes = xml.getBytes(java.nio.charset.StandardCharsets.UTF_8);
    exchange.getResponseHeaders().set("Content-Type", "text/xml");
    exchange.sendResponseHeaders(200, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
