package io.localwebservices.lws.providers.sqs;

import java.util.*;

/** Builds SQS XML response strings. */
class SqsXmlBuilder {

  private SqsXmlBuilder() {}

  static String simpleResponseXml(String action) {
    return "<?xml version=\"1.0\"?><"
        + action
        + "Response xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">"
        + "<ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>"
        + "</"
        + action
        + "Response>";
  }

  static String createQueueXml(String url) {
    return "<?xml version=\"1.0\"?><CreateQueueResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">"
        + "<CreateQueueResult><QueueUrl>"
        + url
        + "</QueueUrl></CreateQueueResult>"
        + "<ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>"
        + "</CreateQueueResponse>";
  }

  static String getQueueUrlXml(String url) {
    return "<?xml version=\"1.0\"?><GetQueueUrlResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">"
        + "<GetQueueUrlResult><QueueUrl>"
        + url
        + "</QueueUrl></GetQueueUrlResult>"
        + "<ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>"
        + "</GetQueueUrlResponse>";
  }

  static String listQueuesXml(List<String> urls) {
    StringBuilder sb =
        new StringBuilder(
            "<?xml version=\"1.0\"?><ListQueuesResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\"><ListQueuesResult>");
    for (String url : urls) sb.append("<QueueUrl>").append(url).append("</QueueUrl>");
    sb.append(
        "</ListQueuesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListQueuesResponse>");
    return sb.toString();
  }

  static String sendMessageXml(String msgId, String md5) {
    return "<?xml version=\"1.0\"?><SendMessageResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">"
        + "<SendMessageResult><MessageId>"
        + msgId
        + "</MessageId><MD5OfMessageBody>"
        + md5
        + "</MD5OfMessageBody></SendMessageResult>"
        + "<ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>"
        + "</SendMessageResponse>";
  }

  static String receiveMessageXml(List<SqsStore.SqsMessage> msgs) {
    StringBuilder sb =
        new StringBuilder(
            "<?xml version=\"1.0\"?><ReceiveMessageResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\"><ReceiveMessageResult>");
    for (SqsStore.SqsMessage msg : msgs) {
      sb.append("<Message>");
      sb.append("<MessageId>").append(msg.messageId).append("</MessageId>");
      sb.append("<ReceiptHandle>").append(msg.receiptHandle).append("</ReceiptHandle>");
      sb.append("<MD5OfBody>").append(SqsStore.md5(msg.body)).append("</MD5OfBody>");
      sb.append("<Body>").append(escapeXml(msg.body)).append("</Body>");
      for (Map.Entry<String, String> e : msg.attributes.entrySet()) {
        sb.append("<Attribute><Name>")
            .append(e.getKey())
            .append("</Name><Value>")
            .append(e.getValue())
            .append("</Value></Attribute>");
      }
      sb.append("</Message>");
    }
    sb.append(
        "</ReceiveMessageResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ReceiveMessageResponse>");
    return sb.toString();
  }

  static String getQueueAttributesXml(Map<String, String> attrs) {
    StringBuilder sb =
        new StringBuilder(
            "<?xml version=\"1.0\"?><GetQueueAttributesResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\"><GetQueueAttributesResult>");
    for (Map.Entry<String, String> e : attrs.entrySet()) {
      sb.append("<Attribute><Name>")
          .append(e.getKey())
          .append("</Name><Value>")
          .append(e.getValue())
          .append("</Value></Attribute>");
    }
    sb.append(
        "</GetQueueAttributesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></GetQueueAttributesResponse>");
    return sb.toString();
  }

  static String listQueueTagsXml(
      @SuppressWarnings("PMD.UnusedFormalParameter") Map<String, String> tags) {
    return simpleResponseXml("ListQueueTags");
  }

  static String escapeXml(String s) {
    if (s == null) return "";
    return s.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace("\"", "&quot;")
        .replace("'", "&apos;");
  }
}
