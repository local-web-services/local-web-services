package io.localwebservices.lws.providers.s3;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.localwebservices.lws.providers.eventbridge.EventBridgeHandler;
import io.localwebservices.lws.providers.lambda.LambdaHandler;
import io.localwebservices.lws.providers.sns.SnsHandler;
import io.localwebservices.lws.providers.sqs.SqsHandler;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Handles S3 bucket notification dispatch. Reads the bucket notification configuration and
 * dispatches events to SNS topics, SQS queues, Lambda functions, or EventBridge buses.
 */
class S3NotificationOps {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final S3Store store;
  private SnsHandler snsHandler;
  private SqsHandler sqsHandler;
  private LambdaHandler lambdaHandler;
  private EventBridgeHandler eventBridgeHandler;

  S3NotificationOps(S3Store store) {
    this.store = store;
  }

  void setSnsHandler(SnsHandler snsHandler) {
    this.snsHandler = snsHandler;
  }

  void setSqsHandler(SqsHandler sqsHandler) {
    this.sqsHandler = sqsHandler;
  }

  void setLambdaHandler(LambdaHandler lambdaHandler) {
    this.lambdaHandler = lambdaHandler;
  }

  void setEventBridgeHandler(EventBridgeHandler eventBridgeHandler) {
    this.eventBridgeHandler = eventBridgeHandler;
  }

  /**
   * Reads the bucket notification configuration and dispatches an S3 event to any configured SNS
   * topics, SQS queues, Lambda functions, or EventBridge buses.
   */
  void dispatchNotification(String bucket, String key, String eventName) {
    String notifXml = store.bucketNotifications.get(bucket);
    if (notifXml == null || notifXml.isEmpty()) {
      return;
    }
    String eventJson = buildEventJson(bucket, key, eventName);
    dispatchToSnsTopics(notifXml, eventJson, eventName);
    dispatchToSqsQueues(notifXml, eventJson, eventName);
    dispatchToLambdaFunctions(notifXml, eventJson, eventName);
    dispatchToEventBridge(notifXml, eventJson, eventName);
  }

  private String buildEventJson(String bucket, String key, String eventName) {
    Map<String, Object> s3Object = new LinkedHashMap<>();
    s3Object.put("key", key);
    Map<String, Object> s3Bucket = new LinkedHashMap<>();
    s3Bucket.put("name", bucket);
    Map<String, Object> s3 = new LinkedHashMap<>();
    s3.put("bucket", s3Bucket);
    s3.put("object", s3Object);
    Map<String, Object> record = new LinkedHashMap<>();
    record.put("eventSource", "aws:s3");
    record.put("eventName", eventName);
    record.put("s3", s3);
    Map<String, Object> event = new LinkedHashMap<>();
    event.put("Records", List.of(record));
    try {
      return MAPPER.writeValueAsString(event);
    } catch (Exception e) {
      return "{\"Records\":[]}";
    }
  }

  private void dispatchToSnsTopics(String notifXml, String eventJson, String eventName) {
    if (snsHandler == null) return;
    int idx = 0;
    while ((idx = notifXml.indexOf("<TopicConfiguration>", idx)) >= 0) {
      int blockEnd = notifXml.indexOf("</TopicConfiguration>", idx);
      if (blockEnd < 0) break;
      String block = notifXml.substring(idx, blockEnd);
      String topicArn = extractXmlValue(block, "Topic");
      String filterEvent = extractXmlValue(block, "Event");
      if (topicArn != null && matchesEvent(filterEvent, eventName)) {
        snsHandler.publishToTopic(topicArn, eventJson);
      }
      idx = blockEnd + 1;
    }
  }

  private void dispatchToSqsQueues(String notifXml, String eventJson, String eventName) {
    if (sqsHandler == null) return;
    int idx = 0;
    while ((idx = notifXml.indexOf("<QueueConfiguration>", idx)) >= 0) {
      int blockEnd = notifXml.indexOf("</QueueConfiguration>", idx);
      if (blockEnd < 0) break;
      String block = notifXml.substring(idx, blockEnd);
      String queueArn = extractXmlValue(block, "Queue");
      String filterEvent = extractXmlValue(block, "Event");
      if (queueArn != null && matchesEvent(filterEvent, eventName)) {
        String queueName = queueArn.substring(queueArn.lastIndexOf(':') + 1);
        sqsHandler.deliverToQueue(queueName, eventJson);
      }
      idx = blockEnd + 1;
    }
  }

  private void dispatchToLambdaFunctions(String notifXml, String eventJson, String eventName) {
    if (lambdaHandler == null) return;
    int idx = 0;
    while ((idx = notifXml.indexOf("<CloudFunctionConfiguration>", idx)) >= 0) {
      int blockEnd = notifXml.indexOf("</CloudFunctionConfiguration>", idx);
      if (blockEnd < 0) break;
      String block = notifXml.substring(idx, blockEnd);
      String functionArn = extractXmlValue(block, "CloudFunction");
      String filterEvent = extractXmlValue(block, "Event");
      if (functionArn != null && matchesEvent(filterEvent, eventName)) {
        String functionName = functionArn.substring(functionArn.lastIndexOf(':') + 1);
        lambdaHandler.invokeFunction(functionName, eventJson);
      }
      idx = blockEnd + 1;
    }
  }

  private void dispatchToEventBridge(String notifXml, String eventJson, String eventName) {
    if (eventBridgeHandler == null) return;
    int idx = 0;
    while ((idx = notifXml.indexOf("<EventBridgeConfiguration>", idx)) >= 0) {
      int blockEnd = notifXml.indexOf("</EventBridgeConfiguration>", idx);
      if (blockEnd < 0) break;
      String block = notifXml.substring(idx, blockEnd);
      String busName = extractXmlValue(block, "EventBridgeBusName");
      if (busName == null) {
        busName = "default";
      }
      Map<String, Object> entry = new LinkedHashMap<>();
      entry.put("EventBusName", busName);
      entry.put("Source", "aws.s3");
      entry.put("DetailType", "Object" + eventName);
      entry.put("Detail", eventJson);
      Map<String, Object> params = new LinkedHashMap<>();
      params.put("Entries", List.of(entry));
      eventBridgeHandler.executePutEvents(params);
      idx = blockEnd + 1;
    }
  }

  private static String extractXmlValue(String xml, String tag) {
    String open = "<" + tag + ">";
    String close = "</" + tag + ">";
    int start = xml.indexOf(open);
    if (start < 0) return null;
    int end = xml.indexOf(close, start);
    if (end < 0) return null;
    return xml.substring(start + open.length(), end);
  }

  /** Returns true if the configured event filter matches the event name. Supports wildcard (*). */
  static boolean matchesEvent(String filter, String eventName) {
    if (filter == null) return true;
    // e.g. filter "s3:ObjectCreated:*" matches "ObjectCreated:Put"
    String normalised = filter.startsWith("s3:") ? filter.substring(3) : filter;
    if (normalised.endsWith(":*")) {
      String prefix = normalised.substring(0, normalised.length() - 1);
      return eventName.startsWith(prefix);
    }
    return normalised.equals(eventName);
  }
}
