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
    private static final String ACCOUNT_ID = "000000000000";

    private final ServerState state;
    private final SqsStore store;

    public SqsHandler(ServerState state, int port) {
        this.state = state;
        this.store = new SqsStore(port);
        state.resetCallbacks.add(store::reset);
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
                action = amzTarget.contains(".") ? amzTarget.substring(amzTarget.lastIndexOf('.') + 1) : amzTarget;
            } else if (jsonBody != null && jsonBody.containsKey("Action")) {
                action = (String) jsonBody.get("Action");
            } else if (formParams.containsKey("Action")) {
                action = formParams.get("Action");
            }

            try {
                if (IamMiddleware.applyIamAuth(state, "sqs", action, exchange, !isJson)) return;
                if (ChaosMiddleware.applyChaos(state, "sqs", action, exchange, !isJson)) return;

                if (isJson) {
                    handleJsonAction(action, jsonBody, exchange.getRequestURI().getPath(), exchange);
                } else {
                    handleFormAction(action, formParams, exchange.getRequestURI().getPath(), exchange);
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                sendError(exchange, "ServiceUnavailable", "Interrupted", isJson, 500);
            } catch (Exception e) {
                sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", e.getMessage() != null ? e.getMessage() : "Error", isJson, 400);
            }
        }
    }

    @SuppressWarnings("unchecked")
    private void handleJsonAction(String action, Map<String, Object> body, String path, HttpExchange exchange) throws IOException {
        switch (action) {
            case "CreateQueue": {
                String name = (String) body.get("QueueName");
                Map<String, String> attrs = (Map<String, String>) body.getOrDefault("Attributes", Map.of());
                if (store.getQueue(name) != null) {
                    sendError(exchange, "QueueAlreadyExists", "A queue already exists with the same name", true, 400);
                    break;
                }
                SqsStore.LocalQueue q = store.createQueue(name, attrs);
                sendJsonResponse(exchange, Map.of("QueueUrl", q.url));
                break;
            }
            case "GetQueueUrl": {
                String name = (String) body.get("QueueName");
                if (store.getQueue(name) == null) {
                    sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "The specified queue does not exist.", true, 400);
                    break;
                }
                sendJsonResponse(exchange, Map.of("QueueUrl", store.queueUrl(name)));
                break;
            }
            case "ListQueues": {
                String prefix = (String) body.get("QueueNamePrefix");
                List<SqsStore.LocalQueue> queues = store.listQueues(prefix);
                List<String> urls = new ArrayList<>();
                for (SqsStore.LocalQueue q : queues) urls.add(q.url);
                sendJsonResponse(exchange, Map.of("QueueUrls", urls));
                break;
            }
            case "DeleteQueue": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                if (store.getQueue(queueUrl) == null) {
                    sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue does not exist.", true, 400);
                    break;
                }
                store.deleteQueue(queueUrl);
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "SendMessage": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found: " + queueUrl, true, 400); return; }
                String msgBody = (String) body.get("MessageBody");
                int delay = body.get("DelaySeconds") != null ? ((Number) body.get("DelaySeconds")).intValue() : 0;
                String msgId = q.sendMessage(msgBody, delay);
                sendJsonResponse(exchange, Map.of("MessageId", msgId, "MD5OfMessageBody", SqsStore.md5(msgBody)));
                break;
            }
            case "SendMessageBatch": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", true, 400); return; }
                List<Map<String, Object>> entries = (List<Map<String, Object>>) body.getOrDefault("Entries", List.of());
                List<Map<String, Object>> successful = new ArrayList<>();
                for (Map<String, Object> entry : entries) {
                    String msgBody = (String) entry.get("MessageBody");
                    int delay = entry.get("DelaySeconds") != null ? ((Number) entry.get("DelaySeconds")).intValue() : 0;
                    String msgId = q.sendMessage(msgBody != null ? msgBody : "", delay);
                    successful.add(Map.of("Id", entry.get("Id"), "MessageId", msgId, "MD5OfMessageBody", SqsStore.md5(msgBody != null ? msgBody : "")));
                }
                sendJsonResponse(exchange, Map.of("Successful", successful, "Failed", List.of()));
                break;
            }
            case "ReceiveMessage": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", true, 400); return; }
                int maxMessages = body.get("MaxNumberOfMessages") != null ? ((Number) body.get("MaxNumberOfMessages")).intValue() : 1;
                List<SqsStore.SqsMessage> msgs = q.receiveMessages(maxMessages);
                List<Map<String, Object>> result = new ArrayList<>();
                for (SqsStore.SqsMessage msg : msgs) {
                    result.add(Map.of("MessageId", msg.messageId, "ReceiptHandle", msg.receiptHandle,
                        "MD5OfBody", SqsStore.md5(msg.body), "Body", msg.body, "Attributes", msg.attributes));
                }
                sendJsonResponse(exchange, Map.of("Messages", result));
                break;
            }
            case "DeleteMessage": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue does not exist.", true, 400); return; }
                String receiptHandle = (String) body.get("ReceiptHandle");
                if (!q.hasMessage(receiptHandle)) {
                    sendError(exchange, "ReceiptHandleIsInvalid", "Invalid receipt handle.", true, 400);
                    return;
                }
                q.deleteMessage(receiptHandle);
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "DeleteMessageBatch": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                List<Map<String, Object>> entries = (List<Map<String, Object>>) body.getOrDefault("Entries", List.of());
                List<Map<String, Object>> successful = new ArrayList<>();
                for (Map<String, Object> entry : entries) {
                    if (q != null) q.deleteMessage((String) entry.get("ReceiptHandle"));
                    successful.add(Map.of("Id", entry.get("Id")));
                }
                sendJsonResponse(exchange, Map.of("Successful", successful, "Failed", List.of()));
                break;
            }
            case "PurgeQueue": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue does not exist.", true, 400); return; }
                q.purge();
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "GetQueueAttributes": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", true, 400); return; }
                Map<String, String> attrs = buildQueueAttributes(q);
                sendJsonResponse(exchange, Map.of("Attributes", attrs));
                break;
            }
            case "SetQueueAttributes": {
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "ChangeMessageVisibility": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue does not exist.", true, 400); return; }
                String receiptHandle = (String) body.get("ReceiptHandle");
                if (!q.hasMessage(receiptHandle)) {
                    sendError(exchange, "ReceiptHandleIsInvalid", "Invalid receipt handle.", true, 400);
                    return;
                }
                int timeout = body.get("VisibilityTimeout") != null ? ((Number) body.get("VisibilityTimeout")).intValue() : 0;
                q.changeVisibility(receiptHandle, timeout);
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "ChangeMessageVisibilityBatch": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                List<Map<String, Object>> entries = (List<Map<String, Object>>) body.getOrDefault("Entries", List.of());
                List<Map<String, Object>> successful = new ArrayList<>();
                for (Map<String, Object> entry : entries) {
                    if (q != null) {
                        int timeout = entry.get("VisibilityTimeout") != null ? ((Number) entry.get("VisibilityTimeout")).intValue() : 0;
                        q.changeVisibility((String) entry.get("ReceiptHandle"), timeout);
                    }
                    successful.add(Map.of("Id", entry.get("Id")));
                }
                sendJsonResponse(exchange, Map.of("Successful", successful, "Failed", List.of()));
                break;
            }
            case "ListQueueTags": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                sendJsonResponse(exchange, Map.of("Tags", store.getQueueTags(queueUrl)));
                break;
            }
            case "TagQueue": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                Map<String, String> tags = (Map<String, String>) body.getOrDefault("Tags", Map.of());
                store.setQueueTags(queueUrl, tags);
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "UntagQueue": {
                String queueUrl = (String) body.get("QueueUrl");
                if (queueUrl == null) queueUrl = extractQueueUrlFromPath(path);
                List<String> tagKeys = (List<String>) body.getOrDefault("TagKeys", List.of());
                store.removeQueueTags(queueUrl, tagKeys);
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "ListDeadLetterSourceQueues": {
                sendJsonResponse(exchange, Map.of("queueUrls", List.of()));
                break;
            }
            default: {
                sendError(exchange, "InvalidAction", "Unknown action: " + action, true, 400);
            }
        }
    }

    private void handleFormAction(String action, Map<String, String> params, String path, HttpExchange exchange) throws IOException {
        // Build adapter: for simple cases, delegate to JSON handler
        Map<String, Object> body = new LinkedHashMap<>();
        body.putAll(params);
        // Handle Attributes
        Map<String, String> attrs = new LinkedHashMap<>();
        for (int i = 1; i <= 20; i++) {
            String name = params.get("Attribute." + i + ".Name");
            String val = params.get("Attribute." + i + ".Value");
            if (name != null) attrs.put(name, val);
        }
        if (!attrs.isEmpty()) body.put("Attributes", attrs);
        // Handle Tags
        Map<String, String> tags = new LinkedHashMap<>();
        for (int i = 1; i <= 20; i++) {
            String key = params.get("Tag." + i + ".Key");
            String val = params.get("Tag." + i + ".Value");
            if (key != null) tags.put(key, val);
        }
        if (!tags.isEmpty()) body.put("Tags", tags);
        // Handle TagKeys
        List<String> tagKeys = new ArrayList<>();
        for (int i = 1; i <= 20; i++) {
            String key = params.get("TagKey." + i);
            if (key != null) tagKeys.add(key);
        }
        if (!tagKeys.isEmpty()) body.put("TagKeys", tagKeys);

        switch (action) {
            case "CreateQueue": {
                String name = params.get("QueueName");
                if (store.getQueue(name) != null) {
                    sendError(exchange, "QueueAlreadyExists", "A queue already exists with the same name", false, 400);
                    break;
                }
                SqsStore.LocalQueue q = store.createQueue(name, attrs.isEmpty() ? new LinkedHashMap<>() : attrs);
                sendXmlResponse(exchange, createQueueXml(q.url));
                break;
            }
            case "GetQueueUrl": {
                String name = params.get("QueueName");
                sendXmlResponse(exchange, getQueueUrlXml(store.queueUrl(name)));
                break;
            }
            case "ListQueues": {
                String prefix = params.get("QueueNamePrefix");
                List<SqsStore.LocalQueue> queues = store.listQueues(prefix);
                List<String> urls = new ArrayList<>();
                for (SqsStore.LocalQueue q : queues) urls.add(q.url);
                sendXmlResponse(exchange, listQueuesXml(urls));
                break;
            }
            case "DeleteQueue": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                if (store.getQueue(queueUrl) == null) {
                    sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue does not exist.", false, 400);
                    break;
                }
                store.deleteQueue(queueUrl);
                sendXmlResponse(exchange, simpleResponseXml("DeleteQueue"));
                break;
            }
            case "SendMessage": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", false, 400); return; }
                String msgBody = params.getOrDefault("MessageBody", "");
                int delay = Integer.parseInt(params.getOrDefault("DelaySeconds", "0"));
                String msgId = q.sendMessage(msgBody, delay);
                sendXmlResponse(exchange, sendMessageXml(msgId, SqsStore.md5(msgBody)));
                break;
            }
            case "ReceiveMessage": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", false, 400); return; }
                int maxMessages = Integer.parseInt(params.getOrDefault("MaxNumberOfMessages", "1"));
                List<SqsStore.SqsMessage> msgs = q.receiveMessages(maxMessages);
                sendXmlResponse(exchange, receiveMessageXml(msgs));
                break;
            }
            case "DeleteMessage": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue does not exist.", false, 400); return; }
                String receiptHandle = params.get("ReceiptHandle");
                if (!q.hasMessage(receiptHandle)) {
                    sendError(exchange, "ReceiptHandleIsInvalid", "Invalid receipt handle.", false, 400);
                    return;
                }
                q.deleteMessage(receiptHandle);
                sendXmlResponse(exchange, simpleResponseXml("DeleteMessage"));
                break;
            }
            case "PurgeQueue": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue does not exist.", false, 400); return; }
                q.purge();
                sendXmlResponse(exchange, simpleResponseXml("PurgeQueue"));
                break;
            }
            case "GetQueueAttributes": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue not found", false, 400); return; }
                Map<String, String> qAttrs = buildQueueAttributes(q);
                sendXmlResponse(exchange, getQueueAttributesXml(qAttrs));
                break;
            }
            case "SetQueueAttributes": {
                sendXmlResponse(exchange, simpleResponseXml("SetQueueAttributes"));
                break;
            }
            case "ListQueueTags": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                Map<String, String> qTags = store.getQueueTags(queueUrl);
                sendXmlResponse(exchange, listQueueTagsXml(qTags));
                break;
            }
            case "TagQueue": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                store.setQueueTags(queueUrl, tags);
                sendXmlResponse(exchange, simpleResponseXml("TagQueue"));
                break;
            }
            case "UntagQueue": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                store.removeQueueTags(queueUrl, tagKeys);
                sendXmlResponse(exchange, simpleResponseXml("UntagQueue"));
                break;
            }
            case "ChangeMessageVisibility": {
                String queueUrl = params.getOrDefault("QueueUrl", extractQueueUrlFromPath(path));
                SqsStore.LocalQueue q = store.getQueue(queueUrl);
                if (q == null) { sendError(exchange, "AWS.SimpleQueueService.NonExistentQueue", "Queue does not exist.", false, 400); return; }
                String receiptHandle = params.get("ReceiptHandle");
                if (!q.hasMessage(receiptHandle)) {
                    sendError(exchange, "ReceiptHandleIsInvalid", "Invalid receipt handle.", false, 400);
                    return;
                }
                int timeout = Integer.parseInt(params.getOrDefault("VisibilityTimeout", "0"));
                q.changeVisibility(receiptHandle, timeout);
                sendXmlResponse(exchange, simpleResponseXml("ChangeMessageVisibility"));
                break;
            }
            case "ChangeMessageVisibilityBatch":
            case "DeleteMessageBatch":
            case "SendMessageBatch":
            case "ListDeadLetterSourceQueues":
            case "AddPermission":
            case "RemovePermission": {
                sendXmlResponse(exchange, simpleResponseXml(action));
                break;
            }
            default: {
                sendError(exchange, "InvalidAction", "Unknown action: " + action, false, 400);
            }
        }
    }

    private Map<String, String> buildQueueAttributes(SqsStore.LocalQueue q) {
        Map<String, String> attrs = new LinkedHashMap<>();
        attrs.put("QueueArn", "arn:aws:sqs:us-east-1:" + ACCOUNT_ID + ":" + q.name);
        attrs.put("ApproximateNumberOfMessages", String.valueOf(q.approximateMessageCount()));
        attrs.put("ApproximateNumberOfMessagesNotVisible", "0");
        attrs.put("VisibilityTimeout", String.valueOf(q.visibilityTimeout));
        attrs.put("CreatedTimestamp", String.valueOf(System.currentTimeMillis() / 1000));
        attrs.put("LastModifiedTimestamp", String.valueOf(System.currentTimeMillis() / 1000));
        attrs.put("FifoQueue", String.valueOf(q.isFifo));
        return attrs;
    }

    private String extractQueueUrlFromPath(String path) {
        return "http://127.0.0.1" + path;
    }

    private void sendJsonResponse(HttpExchange exchange, Object body) throws IOException {
        byte[] bytes = MAPPER.writeValueAsBytes(body);
        exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.0");
        exchange.sendResponseHeaders(200, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
    }

    private void sendXmlResponse(HttpExchange exchange, String xml) throws IOException {
        byte[] bytes = xml.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", "text/xml");
        exchange.sendResponseHeaders(200, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
    }

    private void sendError(HttpExchange exchange, String code, String msg, boolean isJson, int status) throws IOException {
        if (isJson) {
            byte[] bytes = MAPPER.writeValueAsBytes(Map.of("__type", code, "message", msg));
            exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.0");
            exchange.sendResponseHeaders(status, bytes.length);
            try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
        } else {
            String xml = "<?xml version=\"1.0\"?><ErrorResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">" +
                "<Error><Code>" + code + "</Code><Message>" + escapeXml(msg) + "</Message></Error>" +
                "<RequestId>00000000-0000-0000-0000-000000000000</RequestId></ErrorResponse>";
            byte[] bytes = xml.getBytes(StandardCharsets.UTF_8);
            exchange.getResponseHeaders().set("Content-Type", "text/xml");
            exchange.sendResponseHeaders(status, bytes.length);
            try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
        }
    }

    // XML builders
    private String simpleResponseXml(String action) {
        return "<?xml version=\"1.0\"?><" + action + "Response xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">" +
            "<ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>" +
            "</" + action + "Response>";
    }

    private String createQueueXml(String url) {
        return "<?xml version=\"1.0\"?><CreateQueueResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">" +
            "<CreateQueueResult><QueueUrl>" + url + "</QueueUrl></CreateQueueResult>" +
            "<ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>" +
            "</CreateQueueResponse>";
    }

    private String getQueueUrlXml(String url) {
        return "<?xml version=\"1.0\"?><GetQueueUrlResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">" +
            "<GetQueueUrlResult><QueueUrl>" + url + "</QueueUrl></GetQueueUrlResult>" +
            "<ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>" +
            "</GetQueueUrlResponse>";
    }

    private String listQueuesXml(List<String> urls) {
        StringBuilder sb = new StringBuilder("<?xml version=\"1.0\"?><ListQueuesResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\"><ListQueuesResult>");
        for (String url : urls) sb.append("<QueueUrl>").append(url).append("</QueueUrl>");
        sb.append("</ListQueuesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListQueuesResponse>");
        return sb.toString();
    }

    private String sendMessageXml(String msgId, String md5) {
        return "<?xml version=\"1.0\"?><SendMessageResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">" +
            "<SendMessageResult><MessageId>" + msgId + "</MessageId><MD5OfMessageBody>" + md5 + "</MD5OfMessageBody></SendMessageResult>" +
            "<ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>" +
            "</SendMessageResponse>";
    }

    private String receiveMessageXml(List<SqsStore.SqsMessage> msgs) {
        StringBuilder sb = new StringBuilder("<?xml version=\"1.0\"?><ReceiveMessageResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\"><ReceiveMessageResult>");
        for (SqsStore.SqsMessage msg : msgs) {
            sb.append("<Message>");
            sb.append("<MessageId>").append(msg.messageId).append("</MessageId>");
            sb.append("<ReceiptHandle>").append(msg.receiptHandle).append("</ReceiptHandle>");
            sb.append("<MD5OfBody>").append(SqsStore.md5(msg.body)).append("</MD5OfBody>");
            sb.append("<Body>").append(escapeXml(msg.body)).append("</Body>");
            for (Map.Entry<String, String> e : msg.attributes.entrySet()) {
                sb.append("<Attribute><Name>").append(e.getKey()).append("</Name><Value>").append(e.getValue()).append("</Value></Attribute>");
            }
            sb.append("</Message>");
        }
        sb.append("</ReceiveMessageResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ReceiveMessageResponse>");
        return sb.toString();
    }

    private String getQueueAttributesXml(Map<String, String> attrs) {
        StringBuilder sb = new StringBuilder("<?xml version=\"1.0\"?><GetQueueAttributesResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\"><GetQueueAttributesResult>");
        for (Map.Entry<String, String> e : attrs.entrySet()) {
            sb.append("<Attribute><Name>").append(e.getKey()).append("</Name><Value>").append(e.getValue()).append("</Value></Attribute>");
        }
        sb.append("</GetQueueAttributesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></GetQueueAttributesResponse>");
        return sb.toString();
    }

    private String listQueueTagsXml(Map<String, String> tags) {
        return simpleResponseXml("ListQueueTags");
    }

    private String escapeXml(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&apos;");
    }
}
