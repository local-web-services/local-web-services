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
import java.util.concurrent.ConcurrentHashMap;

/** SNS wire-protocol HTTP handler. */
public class SnsHandler implements HttpHandler {

    private static final ObjectMapper MAPPER = new ObjectMapper();
    private static final String ACCOUNT = "000000000000";
    private static final String REGION = "us-east-1";

    private final ServerState state;
    private final Map<String, Map<String, Object>> topics = new ConcurrentHashMap<>();
    private final Map<String, Map<String, Object>> subscriptions = new ConcurrentHashMap<>();
    private final Map<String, Map<String, String>> subscriptionAttrs = new ConcurrentHashMap<>();
    private final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

    public SnsHandler(ServerState state) {
        this.state = state;
        state.resetCallbacks.add(this::reset);
    }

    private void reset() {
        topics.clear();
        subscriptions.clear();
        subscriptionAttrs.clear();
        resourceTags.clear();
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        byte[] bodyBytes;
        try (InputStream is = exchange.getRequestBody()) { bodyBytes = is.readAllBytes(); }
        String contentType = exchange.getRequestHeaders().getFirst("Content-Type");
        if (contentType == null) contentType = "";
        String amzTarget = exchange.getRequestHeaders().getFirst("X-Amz-Target");

        boolean isJson = contentType.contains("application/x-amz-json") || amzTarget != null;

        Map<String, String> formParams = new LinkedHashMap<>();
        Map<String, Object> jsonBody = null;
        String action = "";

        if (isJson) {
            jsonBody = bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
            if (amzTarget != null) action = amzTarget.contains(".") ? amzTarget.substring(amzTarget.lastIndexOf('.') + 1) : amzTarget;
        } else {
            String bodyStr = new String(bodyBytes, StandardCharsets.UTF_8);
            for (String pair : bodyStr.split("&")) {
                if (pair.isEmpty()) continue;
                String[] kv = pair.split("=", 2);
                formParams.put(URLDecoder.decode(kv[0], StandardCharsets.UTF_8), kv.length > 1 ? URLDecoder.decode(kv[1], StandardCharsets.UTF_8) : "");
            }
            action = formParams.getOrDefault("Action", "");
        }

        try {
            if (IamMiddleware.applyIamAuth(state, "sns", action, exchange, !isJson)) return;
            if (ChaosMiddleware.applyChaos(state, "sns", action, exchange, !isJson)) return;

            if (isJson) {
                handleJsonAction(action, jsonBody, exchange);
            } else {
                handleFormAction(action, formParams, exchange);
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            sendError(exchange, "ServiceUnavailable", "Interrupted", isJson, 500);
        } catch (Exception e) {
            sendError(exchange, "InternalError", e.getMessage() != null ? e.getMessage() : "Error", isJson, 400);
        }
    }

    private String topicArn(String name) {
        return "arn:aws:sns:" + REGION + ":" + ACCOUNT + ":" + name;
    }

    @SuppressWarnings("unchecked")
    private void handleJsonAction(String action, Map<String, Object> body, HttpExchange exchange) throws IOException {
        switch (action) {
            case "CreateTopic": {
                String name = (String) body.get("Name");
                String arn = topicArn(name);
                if (topics.containsKey(arn)) {
                    sendError(exchange, "TopicLimitExceeded", "Topic already exists", true, 400);
                    break;
                }
                topics.put(arn, new LinkedHashMap<>(Map.of("TopicArn", arn, "DisplayName", name)));
                sendJsonResponse(exchange, Map.of("TopicArn", arn));
                break;
            }
            case "DeleteTopic": {
                String arn = (String) body.get("TopicArn");
                if (!topics.containsKey(arn)) {
                    sendError(exchange, "NotFound", "Topic not found: " + arn, true, 400);
                    break;
                }
                topics.remove(arn);
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "ListTopics": {
                List<Map<String, Object>> list = new ArrayList<>();
                for (String arn : topics.keySet()) list.add(Map.of("TopicArn", arn));
                sendJsonResponse(exchange, Map.of("Topics", list));
                break;
            }
            case "Publish": {
                String publishTopicArn = (String) body.get("TopicArn");
                if (publishTopicArn == null || !topics.containsKey(publishTopicArn)) {
                    sendError(exchange, "NotFound", "Topic not found: " + publishTopicArn, true, 400);
                    break;
                }
                // Check if any subscription exists for this topic
                boolean hasSubscription = subscriptions.values().stream()
                    .anyMatch(sub -> publishTopicArn.equals(sub.get("TopicArn")));
                if (!hasSubscription) {
                    sendError(exchange, "InvalidParameter", "No confirmed subscriptions for topic: " + publishTopicArn, true, 400);
                    break;
                }
                String msgId = UUID.randomUUID().toString();
                sendJsonResponse(exchange, Map.of("MessageId", msgId));
                break;
            }
            case "Subscribe": {
                String topicArn = (String) body.get("TopicArn");
                if (topicArn == null || !topics.containsKey(topicArn)) {
                    sendError(exchange, "NotFound", "Topic not found: " + topicArn, true, 400);
                    break;
                }
                String arn = UUID.randomUUID().toString();
                Map<String, Object> sub = new LinkedHashMap<>(body);
                sub.put("SubscriptionArn", arn);
                subscriptions.put(arn, sub);
                sendJsonResponse(exchange, Map.of("SubscriptionArn", arn));
                break;
            }
            case "Unsubscribe": {
                String arn = (String) body.get("SubscriptionArn");
                if (!subscriptions.containsKey(arn)) {
                    sendError(exchange, "NotFound", "Subscription not found: " + arn, true, 400);
                    break;
                }
                subscriptions.remove(arn);
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "ListSubscriptions": {
                List<Map<String, Object>> list = new ArrayList<>(subscriptions.values());
                sendJsonResponse(exchange, Map.of("Subscriptions", list));
                break;
            }
            case "ListSubscriptionsByTopic": {
                String topicArn = (String) body.get("TopicArn");
                List<Map<String, Object>> list = new ArrayList<>();
                for (Map<String, Object> sub : subscriptions.values()) {
                    if (topicArn.equals(sub.get("TopicArn"))) list.add(sub);
                }
                sendJsonResponse(exchange, Map.of("Subscriptions", list));
                break;
            }
            case "GetTopicAttributes": {
                String arn = (String) body.get("TopicArn");
                Map<String, Object> topic = topics.getOrDefault(arn, Map.of());
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
            case "SetTopicAttributes": {
                String topicArn = (String) body.get("TopicArn");
                String attrName = (String) body.get("AttributeName");
                String attrValue = (String) body.get("AttributeValue");
                Map<String, Object> topic = topics.get(topicArn);
                if (topic != null && attrName != null) topic.put(attrName, attrValue != null ? attrValue : "");
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "GetSubscriptionAttributes": {
                String subArn = (String) body.get("SubscriptionArn");
                Map<String, String> attrs = subscriptionAttrs.getOrDefault(subArn, new LinkedHashMap<>());
                Map<String, Object> sub = subscriptions.get(subArn);
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
            case "SetSubscriptionAttributes": {
                String subArn = (String) body.get("SubscriptionArn");
                String attrName = (String) body.get("AttributeName");
                String attrValue = (String) body.get("AttributeValue");
                if (attrName != null) {
                    subscriptionAttrs.computeIfAbsent(subArn, k -> new LinkedHashMap<>()).put(attrName, attrValue != null ? attrValue : "");
                }
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "ConfirmSubscription": {
                sendJsonResponse(exchange, Map.of("SubscriptionArn", UUID.randomUUID().toString()));
                break;
            }
            case "ListTagsForResource": {
                String resourceArn = (String) body.get("ResourceArn");
                List<Map<String, String>> tags = resourceTags.getOrDefault(resourceArn, List.of());
                sendJsonResponse(exchange, Map.of("Tags", tags));
                break;
            }
            case "TagResource": {
                String resourceArn = (String) body.get("ResourceArn");
                List<Map<String, Object>> newTags = (List<Map<String, Object>>) body.getOrDefault("Tags", List.of());
                List<Map<String, String>> existing = resourceTags.computeIfAbsent(resourceArn, k -> new ArrayList<>());
                for (Map<String, Object> tag : newTags) {
                    existing.add(Map.of("Key", (String) tag.get("Key"), "Value", (String) tag.get("Value")));
                }
                sendJsonResponse(exchange, Map.of());
                break;
            }
            case "UntagResource": {
                String resourceArn = (String) body.get("ResourceArn");
                List<String> tagKeys = (List<String>) body.getOrDefault("TagKeys", List.of());
                List<Map<String, String>> existing = resourceTags.getOrDefault(resourceArn, new ArrayList<>());
                existing.removeIf(t -> tagKeys.contains(t.get("Key")));
                sendJsonResponse(exchange, Map.of());
                break;
            }
            default: sendError(exchange, "InvalidAction", "Unknown: " + action, true, 400);
        }
    }

    @SuppressWarnings("unchecked")
    private void handleFormAction(String action, Map<String, String> params, HttpExchange exchange) throws IOException {
        switch (action) {
            case "CreateTopic": {
                String name = params.get("Name");
                String arn = topicArn(name);
                if (topics.containsKey(arn)) {
                    sendError(exchange, "TopicLimitExceeded", "Topic already exists", false, 400);
                    break;
                }
                topics.put(arn, new LinkedHashMap<>(Map.of("TopicArn", arn)));
                sendXmlResponse(exchange, "<CreateTopicResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><CreateTopicResult><TopicArn>" + arn + "</TopicArn></CreateTopicResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></CreateTopicResponse>");
                break;
            }
            case "DeleteTopic": {
                String topicArnToDelete = params.get("TopicArn");
                if (!topics.containsKey(topicArnToDelete)) {
                    sendError(exchange, "NotFound", "Topic not found: " + topicArnToDelete, false, 400);
                    break;
                }
                topics.remove(topicArnToDelete);
                sendXmlResponse(exchange, simpleXml("DeleteTopic"));
                break;
            }
            case "ListTopics": {
                StringBuilder sb = new StringBuilder("<ListTopicsResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><ListTopicsResult><Topics>");
                for (String arn : topics.keySet()) sb.append("<member><TopicArn>").append(arn).append("</TopicArn></member>");
                sb.append("</Topics></ListTopicsResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListTopicsResponse>");
                sendXmlResponse(exchange, sb.toString());
                break;
            }
            case "Publish": {
                String publishTopicArn = params.get("TopicArn");
                if (publishTopicArn == null || !topics.containsKey(publishTopicArn)) {
                    sendError(exchange, "NotFound", "Topic not found: " + publishTopicArn, false, 400);
                    break;
                }
                boolean hasSubscription = subscriptions.values().stream()
                    .anyMatch(sub -> publishTopicArn.equals(sub.get("TopicArn")));
                if (!hasSubscription) {
                    sendError(exchange, "InvalidParameter", "No confirmed subscriptions for topic: " + publishTopicArn, false, 400);
                    break;
                }
                String msgId = UUID.randomUUID().toString();
                sendXmlResponse(exchange, "<PublishResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><PublishResult><MessageId>" + msgId + "</MessageId></PublishResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></PublishResponse>");
                break;
            }
            case "Subscribe": {
                String topicArn = params.get("TopicArn");
                if (topicArn == null || !topics.containsKey(topicArn)) {
                    sendError(exchange, "NotFound", "Topic not found: " + topicArn, false, 400);
                    break;
                }
                String subArn = UUID.randomUUID().toString();
                Map<String, Object> sub = new LinkedHashMap<>();
                sub.put("SubscriptionArn", subArn);
                sub.put("TopicArn", topicArn);
                sub.put("Protocol", params.get("Protocol"));
                sub.put("Endpoint", params.get("Endpoint"));
                subscriptions.put(subArn, sub);
                sendXmlResponse(exchange, "<SubscribeResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><SubscribeResult><SubscriptionArn>" + subArn + "</SubscriptionArn></SubscribeResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></SubscribeResponse>");
                break;
            }
            case "Unsubscribe": {
                String subArn = params.get("SubscriptionArn");
                if (!subscriptions.containsKey(subArn)) {
                    sendError(exchange, "NotFound", "Subscription not found: " + subArn, false, 400);
                    break;
                }
                subscriptions.remove(subArn);
                sendXmlResponse(exchange, simpleXml(action));
                break;
            }
            case "ListSubscriptionsByTopic": {
                String topicArn = params.get("TopicArn");
                StringBuilder sb = new StringBuilder("<ListSubscriptionsByTopicResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><ListSubscriptionsByTopicResult><Subscriptions>");
                for (Map<String, Object> s : subscriptions.values()) {
                    if (topicArn.equals(s.get("TopicArn"))) {
                        sb.append("<member><SubscriptionArn>").append(s.get("SubscriptionArn")).append("</SubscriptionArn>");
                        sb.append("<Protocol>").append(s.getOrDefault("Protocol", "")).append("</Protocol>");
                        sb.append("<Endpoint>").append(s.getOrDefault("Endpoint", "")).append("</Endpoint>");
                        sb.append("<TopicArn>").append(s.get("TopicArn")).append("</TopicArn></member>");
                    }
                }
                sb.append("</Subscriptions></ListSubscriptionsByTopicResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListSubscriptionsByTopicResponse>");
                sendXmlResponse(exchange, sb.toString());
                break;
            }
            case "SetTopicAttributes": {
                String topicArn = params.get("TopicArn");
                String attrName = params.get("AttributeName");
                String attrValue = params.get("AttributeValue");
                Map<String, Object> topic = topics.get(topicArn);
                if (topic != null && attrName != null) topic.put(attrName, attrValue != null ? attrValue : "");
                sendXmlResponse(exchange, simpleXml(action));
                break;
            }
            case "GetTopicAttributes": {
                String topicArn = params.get("TopicArn");
                Map<String, Object> topic = topics.getOrDefault(topicArn, Map.of());
                StringBuilder attrSb = new StringBuilder();
                attrSb.append("<entry><key>TopicArn</key><value>").append(topicArn).append("</value></entry>");
                String displayName = topic.containsKey("DisplayName") ? (String) topic.get("DisplayName") : "";
                attrSb.append("<entry><key>DisplayName</key><value>").append(displayName).append("</value></entry>");
                attrSb.append("<entry><key>SubscriptionsConfirmed</key><value>0</value></entry>");
                attrSb.append("<entry><key>SubscriptionsPending</key><value>0</value></entry>");
                String attrXml = "<GetTopicAttributesResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><GetTopicAttributesResult><Attributes>" + attrSb + "</Attributes></GetTopicAttributesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></GetTopicAttributesResponse>";
                sendXmlResponse(exchange, attrXml);
                break;
            }
            case "GetSubscriptionAttributes": {
                String subArn = params.get("SubscriptionArn");
                Map<String, String> sAttrs = subscriptionAttrs.getOrDefault(subArn, new LinkedHashMap<>());
                Map<String, Object> sub = subscriptions.get(subArn);
                StringBuilder attrSb = new StringBuilder();
                attrSb.append("<entry><key>SubscriptionArn</key><value>").append(subArn).append("</value></entry>");
                if (sub != null) {
                    if (sub.get("Protocol") != null) attrSb.append("<entry><key>Protocol</key><value>").append(sub.get("Protocol")).append("</value></entry>");
                    if (sub.get("Endpoint") != null) attrSb.append("<entry><key>Endpoint</key><value>").append(sub.get("Endpoint")).append("</value></entry>");
                    if (sub.get("TopicArn") != null) attrSb.append("<entry><key>TopicArn</key><value>").append(sub.get("TopicArn")).append("</value></entry>");
                }
                for (Map.Entry<String, String> e : sAttrs.entrySet()) {
                    attrSb.append("<entry><key>").append(e.getKey()).append("</key><value>").append(e.getValue()).append("</value></entry>");
                }
                String subAttrXml = "<GetSubscriptionAttributesResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><GetSubscriptionAttributesResult><Attributes>" + attrSb + "</Attributes></GetSubscriptionAttributesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></GetSubscriptionAttributesResponse>";
                sendXmlResponse(exchange, subAttrXml);
                break;
            }
            case "SetSubscriptionAttributes": {
                String subArn = params.get("SubscriptionArn");
                String attrName = params.get("AttributeName");
                String attrValue = params.get("AttributeValue");
                if (attrName != null) {
                    subscriptionAttrs.computeIfAbsent(subArn, k -> new LinkedHashMap<>()).put(attrName, attrValue != null ? attrValue : "");
                }
                sendXmlResponse(exchange, simpleXml(action));
                break;
            }
            case "ConfirmSubscription":
            case "ListSubscriptions": {
                sendXmlResponse(exchange, simpleXml(action));
                break;
            }
            case "ListTagsForResource": {
                String resourceArn = params.get("ResourceArn");
                List<Map<String, String>> tags = resourceTags.getOrDefault(resourceArn, List.of());
                StringBuilder tagSb = new StringBuilder("<ListTagsForResourceResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><ListTagsForResourceResult><Tags>");
                for (Map<String, String> tag : tags) {
                    tagSb.append("<member><Key>").append(tag.get("Key")).append("</Key><Value>").append(tag.get("Value")).append("</Value></member>");
                }
                tagSb.append("</Tags></ListTagsForResourceResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListTagsForResourceResponse>");
                sendXmlResponse(exchange, tagSb.toString());
                break;
            }
            case "TagResource": {
                String resourceArn = params.get("ResourceArn");
                List<Map<String, String>> existing = resourceTags.computeIfAbsent(resourceArn, k -> new ArrayList<>());
                // Parse tags from form params: Tags.member.N.Key and Tags.member.N.Value
                for (int idx = 1; ; idx++) {
                    String tagKey = params.get("Tags.member." + idx + ".Key");
                    String tagValue = params.get("Tags.member." + idx + ".Value");
                    if (tagKey == null) break;
                    existing.add(Map.of("Key", tagKey, "Value", tagValue != null ? tagValue : ""));
                }
                sendXmlResponse(exchange, simpleXml(action));
                break;
            }
            case "UntagResource": {
                String resourceArn = params.get("ResourceArn");
                List<Map<String, String>> existingTags = resourceTags.getOrDefault(resourceArn, new ArrayList<>());
                // Parse tag keys from form params: TagKeys.member.N
                for (int idx = 1; ; idx++) {
                    String tagKey = params.get("TagKeys.member." + idx);
                    if (tagKey == null) break;
                    String finalTagKey = tagKey;
                    existingTags.removeIf(t -> finalTagKey.equals(t.get("Key")));
                }
                sendXmlResponse(exchange, simpleXml(action));
                break;
            }
            default: {
                sendError(exchange, "InvalidAction", "Unknown: " + action, false, 400);
            }
        }
    }

    private String simpleXml(String action) {
        return "<" + action + "Response xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></" + action + "Response>";
    }

    private void sendJsonResponse(HttpExchange exchange, Object body) throws IOException {
        byte[] bytes = MAPPER.writeValueAsBytes(body);
        exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.0");
        exchange.sendResponseHeaders(200, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
    }

    private void sendXmlResponse(HttpExchange exchange, String xml) throws IOException {
        byte[] bytes = ("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + xml).getBytes(StandardCharsets.UTF_8);
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
            String xml = "<?xml version=\"1.0\"?><ErrorResponse><Error><Code>" + code + "</Code><Message>" + msg + "</Message></Error><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ErrorResponse>";
            byte[] bytes = xml.getBytes(StandardCharsets.UTF_8);
            exchange.getResponseHeaders().set("Content-Type", "text/xml");
            exchange.sendResponseHeaders(status, bytes.length);
            try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
        }
    }
}
