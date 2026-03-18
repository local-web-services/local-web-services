package io.localwebservices.lws.providers.s3;

import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;

/** Handles S3 bucket configuration operations: tagging, policy, website, notification. */
class S3BucketConfigOps {

  private final S3Store store;

  S3BucketConfigOps(S3Store store) {
    this.store = store;
  }

  /**
   * Returns true if the operation was handled. Returns false for unrecognised operations, which
   * fall through to the default handler.
   */
  boolean handle(String operation, String bucket, HttpExchange exchange) throws IOException {
    switch (operation) {
      case "GetBucketLocation":
        {
          S3HttpHelper.sendXml(
              exchange,
              200,
              "<?xml version=\"1.0\" encoding=\"UTF-8\"?><LocationConstraint xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">us-east-1</LocationConstraint>");
          return true;
        }
      case "GetBucketTagging":
        {
          Map<String, String> tags = store.bucketTags.getOrDefault(bucket, Map.of());
          StringBuilder sb =
              new StringBuilder(
                  "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Tagging xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\"><TagSet>");
          for (Map.Entry<String, String> e : tags.entrySet()) {
            sb.append("<Tag><Key>")
                .append(e.getKey())
                .append("</Key><Value>")
                .append(e.getValue())
                .append("</Value></Tag>");
          }
          sb.append("</TagSet></Tagging>");
          S3HttpHelper.sendXml(exchange, 200, sb.toString());
          return true;
        }
      case "PutBucketVersioning":
        {
          if (!store.buckets.containsKey(bucket)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
            return true;
          }
          S3HttpHelper.sendEmpty(exchange, 200);
          return true;
        }
      case "PutBucketTagging":
        {
          S3HttpHelper.sendEmpty(exchange, 200);
          return true;
        }
      case "DeleteBucketTagging":
        {
          store.bucketTags.remove(bucket);
          S3HttpHelper.sendEmpty(exchange, 204);
          return true;
        }
      case "GetBucketPolicy":
        {
          String policy = store.bucketPolicies.get(bucket);
          if (policy == null) {
            S3HttpHelper.sendS3Error(exchange, 404, "NoSuchBucketPolicy", "No policy");
            return true;
          }
          byte[] bytes = policy.getBytes(StandardCharsets.UTF_8);
          exchange.getResponseHeaders().set("Content-Type", "application/json");
          exchange.sendResponseHeaders(200, bytes.length);
          try (OutputStream os = exchange.getResponseBody()) {
            os.write(bytes);
          }
          return true;
        }
      case "PutBucketPolicy":
        {
          byte[] body;
          try (InputStream is = exchange.getRequestBody()) {
            body = is.readAllBytes();
          }
          store.bucketPolicies.put(bucket, new String(body, StandardCharsets.UTF_8));
          S3HttpHelper.sendEmpty(exchange, 200);
          return true;
        }
      case "GetBucketNotificationConfiguration":
        {
          S3HttpHelper.sendXml(
              exchange,
              200,
              "<?xml version=\"1.0\" encoding=\"UTF-8\"?><NotificationConfiguration xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\"></NotificationConfiguration>");
          return true;
        }
      case "PutBucketNotificationConfiguration":
        {
          S3HttpHelper.sendEmpty(exchange, 200);
          return true;
        }
      case "GetBucketWebsite":
        {
          Map<String, String> webCfg = store.bucketWebsites.get(bucket);
          if (webCfg == null) {
            S3HttpHelper.sendS3Error(
                exchange,
                404,
                "NoSuchWebsiteConfiguration",
                "The specified bucket does not have a website configuration");
            return true;
          }
          String indexSuffix = webCfg.getOrDefault("indexSuffix", "index.html");
          String errorKey = webCfg.getOrDefault("errorKey", "error.html");
          String xml =
              "<?xml version=\"1.0\" encoding=\"UTF-8\"?><WebsiteConfiguration xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">"
                  + "<IndexDocument><Suffix>"
                  + indexSuffix
                  + "</Suffix></IndexDocument>"
                  + "<ErrorDocument><Key>"
                  + errorKey
                  + "</Key></ErrorDocument>"
                  + "</WebsiteConfiguration>";
          S3HttpHelper.sendXml(exchange, 200, xml);
          return true;
        }
      case "PutBucketWebsite":
        {
          byte[] body;
          try (InputStream is = exchange.getRequestBody()) {
            body = is.readAllBytes();
          }
          String bodyStr = new String(body, StandardCharsets.UTF_8);
          Map<String, String> webCfg = new LinkedHashMap<>();
          int suffixStart = bodyStr.indexOf("<Suffix>");
          int suffixEnd = bodyStr.indexOf("</Suffix>");
          if (suffixStart >= 0 && suffixEnd > suffixStart) {
            webCfg.put("indexSuffix", bodyStr.substring(suffixStart + 8, suffixEnd));
          } else {
            webCfg.put("indexSuffix", "index.html");
          }
          int errStart = bodyStr.indexOf("<Key>");
          int errEnd = bodyStr.indexOf("</Key>");
          if (errStart >= 0 && errEnd > errStart) {
            webCfg.put("errorKey", bodyStr.substring(errStart + 5, errEnd));
          } else {
            webCfg.put("errorKey", "error.html");
          }
          store.bucketWebsites.put(bucket, webCfg);
          S3HttpHelper.sendEmpty(exchange, 200);
          return true;
        }
      case "DeleteBucketWebsite":
        {
          store.bucketWebsites.remove(bucket);
          S3HttpHelper.sendEmpty(exchange, 204);
          return true;
        }
      default:
        return false;
    }
  }
}
