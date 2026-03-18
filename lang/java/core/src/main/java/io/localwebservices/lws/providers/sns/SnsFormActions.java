package io.localwebservices.lws.providers.sns;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/** Handles SNS form-encoded (query protocol) actions. */
class SnsFormActions {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final SnsStore store;

  SnsFormActions(SnsStore store) {
    this.store = store;
  }

  @SuppressWarnings("unchecked")
  void handle(String action, Map<String, String> params, HttpExchange exchange) throws IOException {
    switch (action) {
      case "CreateTopic":
        {
          String name = params.get("Name");
          String arn = store.topicArn(name);
          if (store.topics.containsKey(arn)) {
            sendError(exchange, "TopicLimitExceeded", "Topic already exists", false, 400);
            break;
          }
          store.topics.put(arn, new LinkedHashMap<>(Map.of("TopicArn", arn)));
          sendXmlResponse(
              exchange,
              "<CreateTopicResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><CreateTopicResult><TopicArn>"
                  + arn
                  + "</TopicArn></CreateTopicResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></CreateTopicResponse>");
          break;
        }
      case "DeleteTopic":
        {
          String topicArnToDelete = params.get("TopicArn");
          if (!store.topics.containsKey(topicArnToDelete)) {
            sendError(exchange, "NotFound", "Topic not found: " + topicArnToDelete, false, 400);
            break;
          }
          store.topics.remove(topicArnToDelete);
          sendXmlResponse(exchange, simpleXml("DeleteTopic"));
          break;
        }
      case "ListTopics":
        {
          StringBuilder sb =
              new StringBuilder(
                  "<ListTopicsResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><ListTopicsResult><Topics>");
          for (String arn : store.topics.keySet())
            sb.append("<member><TopicArn>").append(arn).append("</TopicArn></member>");
          sb.append(
              "</Topics></ListTopicsResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListTopicsResponse>");
          sendXmlResponse(exchange, sb.toString());
          break;
        }
      case "Publish":
        {
          String publishTopicArn = params.get("TopicArn");
          if (publishTopicArn == null || !store.topics.containsKey(publishTopicArn)) {
            sendError(exchange, "NotFound", "Topic not found: " + publishTopicArn, false, 400);
            break;
          }
          boolean hasSubscription =
              store.subscriptions.values().stream()
                  .anyMatch(sub -> publishTopicArn.equals(sub.get("TopicArn")));
          if (!hasSubscription) {
            sendError(
                exchange,
                "InvalidParameter",
                "No confirmed subscriptions for topic: " + publishTopicArn,
                false,
                400);
            break;
          }
          String msgId = UUID.randomUUID().toString();
          sendXmlResponse(
              exchange,
              "<PublishResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><PublishResult><MessageId>"
                  + msgId
                  + "</MessageId></PublishResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></PublishResponse>");
          break;
        }
      case "Subscribe":
        {
          String topicArn = params.get("TopicArn");
          if (topicArn == null || !store.topics.containsKey(topicArn)) {
            sendError(exchange, "NotFound", "Topic not found: " + topicArn, false, 400);
            break;
          }
          String subArn = UUID.randomUUID().toString();
          Map<String, Object> sub = new LinkedHashMap<>();
          sub.put("SubscriptionArn", subArn);
          sub.put("TopicArn", topicArn);
          sub.put("Protocol", params.get("Protocol"));
          sub.put("Endpoint", params.get("Endpoint"));
          store.subscriptions.put(subArn, sub);
          sendXmlResponse(
              exchange,
              "<SubscribeResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><SubscribeResult><SubscriptionArn>"
                  + subArn
                  + "</SubscriptionArn></SubscribeResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></SubscribeResponse>");
          break;
        }
      case "Unsubscribe":
        {
          String subArn = params.get("SubscriptionArn");
          if (!store.subscriptions.containsKey(subArn)) {
            sendError(exchange, "NotFound", "Subscription not found: " + subArn, false, 400);
            break;
          }
          store.subscriptions.remove(subArn);
          sendXmlResponse(exchange, simpleXml(action));
          break;
        }
      case "ListSubscriptionsByTopic":
        {
          String topicArn = params.get("TopicArn");
          StringBuilder sb =
              new StringBuilder(
                  "<ListSubscriptionsByTopicResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><ListSubscriptionsByTopicResult><Subscriptions>");
          for (Map<String, Object> s : store.subscriptions.values()) {
            if (topicArn.equals(s.get("TopicArn"))) {
              sb.append("<member><SubscriptionArn>")
                  .append(s.get("SubscriptionArn"))
                  .append("</SubscriptionArn>");
              sb.append("<Protocol>").append(s.getOrDefault("Protocol", "")).append("</Protocol>");
              sb.append("<Endpoint>").append(s.getOrDefault("Endpoint", "")).append("</Endpoint>");
              sb.append("<TopicArn>").append(s.get("TopicArn")).append("</TopicArn></member>");
            }
          }
          sb.append(
              "</Subscriptions></ListSubscriptionsByTopicResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListSubscriptionsByTopicResponse>");
          sendXmlResponse(exchange, sb.toString());
          break;
        }
      case "SetTopicAttributes":
        {
          String topicArn = params.get("TopicArn");
          String attrName = params.get("AttributeName");
          String attrValue = params.get("AttributeValue");
          Map<String, Object> topic = store.topics.get(topicArn);
          if (topic != null && attrName != null)
            topic.put(attrName, attrValue != null ? attrValue : "");
          sendXmlResponse(exchange, simpleXml(action));
          break;
        }
      case "GetTopicAttributes":
        {
          String topicArn = params.get("TopicArn");
          Map<String, Object> topic = store.topics.getOrDefault(topicArn, Map.of());
          StringBuilder attrSb = new StringBuilder();
          attrSb
              .append("<entry><key>TopicArn</key><value>")
              .append(topicArn)
              .append("</value></entry>");
          String displayName =
              topic.containsKey("DisplayName") ? (String) topic.get("DisplayName") : "";
          attrSb
              .append("<entry><key>DisplayName</key><value>")
              .append(displayName)
              .append("</value></entry>");
          attrSb.append("<entry><key>SubscriptionsConfirmed</key><value>0</value></entry>");
          attrSb.append("<entry><key>SubscriptionsPending</key><value>0</value></entry>");
          String attrXml =
              "<GetTopicAttributesResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><GetTopicAttributesResult><Attributes>"
                  + attrSb
                  + "</Attributes></GetTopicAttributesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></GetTopicAttributesResponse>";
          sendXmlResponse(exchange, attrXml);
          break;
        }
      case "GetSubscriptionAttributes":
        {
          String subArn = params.get("SubscriptionArn");
          Map<String, String> sAttrs =
              store.subscriptionAttrs.getOrDefault(subArn, new LinkedHashMap<>());
          Map<String, Object> sub = store.subscriptions.get(subArn);
          StringBuilder attrSb = new StringBuilder();
          attrSb
              .append("<entry><key>SubscriptionArn</key><value>")
              .append(subArn)
              .append("</value></entry>");
          if (sub != null) {
            if (sub.get("Protocol") != null)
              attrSb
                  .append("<entry><key>Protocol</key><value>")
                  .append(sub.get("Protocol"))
                  .append("</value></entry>");
            if (sub.get("Endpoint") != null)
              attrSb
                  .append("<entry><key>Endpoint</key><value>")
                  .append(sub.get("Endpoint"))
                  .append("</value></entry>");
            if (sub.get("TopicArn") != null)
              attrSb
                  .append("<entry><key>TopicArn</key><value>")
                  .append(sub.get("TopicArn"))
                  .append("</value></entry>");
          }
          for (Map.Entry<String, String> e : sAttrs.entrySet()) {
            attrSb
                .append("<entry><key>")
                .append(e.getKey())
                .append("</key><value>")
                .append(e.getValue())
                .append("</value></entry>");
          }
          String subAttrXml =
              "<GetSubscriptionAttributesResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><GetSubscriptionAttributesResult><Attributes>"
                  + attrSb
                  + "</Attributes></GetSubscriptionAttributesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></GetSubscriptionAttributesResponse>";
          sendXmlResponse(exchange, subAttrXml);
          break;
        }
      case "SetSubscriptionAttributes":
        {
          String subArn = params.get("SubscriptionArn");
          String attrName = params.get("AttributeName");
          String attrValue = params.get("AttributeValue");
          if (attrName != null) {
            store
                .subscriptionAttrs
                .computeIfAbsent(subArn, k -> new LinkedHashMap<>())
                .put(attrName, attrValue != null ? attrValue : "");
          }
          sendXmlResponse(exchange, simpleXml(action));
          break;
        }
      case "ConfirmSubscription":
      case "ListSubscriptions":
        {
          sendXmlResponse(exchange, simpleXml(action));
          break;
        }
      case "ListTagsForResource":
        {
          String resourceArn = params.get("ResourceArn");
          List<Map<String, String>> tags = store.resourceTags.getOrDefault(resourceArn, List.of());
          StringBuilder tagSb =
              new StringBuilder(
                  "<ListTagsForResourceResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><ListTagsForResourceResult><Tags>");
          for (Map<String, String> tag : tags) {
            tagSb
                .append("<member><Key>")
                .append(tag.get("Key"))
                .append("</Key><Value>")
                .append(tag.get("Value"))
                .append("</Value></member>");
          }
          tagSb.append(
              "</Tags></ListTagsForResourceResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListTagsForResourceResponse>");
          sendXmlResponse(exchange, tagSb.toString());
          break;
        }
      case "TagResource":
        {
          String resourceArn = params.get("ResourceArn");
          List<Map<String, String>> existing =
              store.resourceTags.computeIfAbsent(resourceArn, k -> new ArrayList<>());
          for (int idx = 1; ; idx++) {
            String tagKey = params.get("Tags.member." + idx + ".Key");
            String tagValue = params.get("Tags.member." + idx + ".Value");
            if (tagKey == null) break;
            existing.add(Map.of("Key", tagKey, "Value", tagValue != null ? tagValue : ""));
          }
          sendXmlResponse(exchange, simpleXml(action));
          break;
        }
      case "UntagResource":
        {
          String resourceArn = params.get("ResourceArn");
          List<Map<String, String>> existingTags =
              store.resourceTags.getOrDefault(resourceArn, new ArrayList<>());
          for (int idx = 1; ; idx++) {
            String tagKey = params.get("TagKeys.member." + idx);
            if (tagKey == null) break;
            String finalTagKey = tagKey;
            existingTags.removeIf(t -> finalTagKey.equals(t.get("Key")));
          }
          sendXmlResponse(exchange, simpleXml(action));
          break;
        }
      default:
        {
          sendError(exchange, "InvalidAction", "Unknown: " + action, false, 400);
        }
    }
  }

  private String simpleXml(String action) {
    return "<"
        + action
        + "Response xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></"
        + action
        + "Response>";
  }

  private void sendXmlResponse(HttpExchange exchange, String xml) throws IOException {
    byte[] bytes = xml.getBytes(java.nio.charset.StandardCharsets.UTF_8);
    exchange.getResponseHeaders().set("Content-Type", "text/xml");
    exchange.sendResponseHeaders(200, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
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
          "<ErrorResponse xmlns=\"https://sns.amazonaws.com/doc/2010-03-31/\"><Error><Type>Sender</Type><Code>"
              + code
              + "</Code><Message>"
              + msg
              + "</Message></Error><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ErrorResponse>";
      byte[] bytes = xml.getBytes(java.nio.charset.StandardCharsets.UTF_8);
      exchange.getResponseHeaders().set("Content-Type", "text/xml");
      exchange.sendResponseHeaders(status, bytes.length);
      try (OutputStream os = exchange.getResponseBody()) {
        os.write(bytes);
      }
    }
  }
}
