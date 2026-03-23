package io.localwebservices.lws.providers.s3;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import io.localwebservices.lws.providers.eventbridge.EventBridgeHandler;
import io.localwebservices.lws.providers.lambda.LambdaHandler;
import io.localwebservices.lws.providers.sns.SnsHandler;
import io.localwebservices.lws.providers.sqs.SqsHandler;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** S3 wire-protocol HTTP handler. */
public class S3Handler implements HttpHandler {

  private final ServerState state;
  private final S3Store store = new S3Store();
  private final S3BucketConfigOps bucketConfigOps = new S3BucketConfigOps(store);
  private final S3MultipartOps multipartOps = new S3MultipartOps(store);
  private final S3NotificationOps notificationOps = new S3NotificationOps(store);

  public S3Handler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(store::reset);
  }

  /** Wires in the SNS handler so that S3 can dispatch notifications to SNS topics. */
  public void setSnsHandler(SnsHandler snsHandler) {
    notificationOps.setSnsHandler(snsHandler);
  }

  /** Wires in the SQS handler so that S3 can dispatch notifications to SQS queues. */
  public void setSqsHandler(SqsHandler sqsHandler) {
    notificationOps.setSqsHandler(sqsHandler);
  }

  /** Wires in the Lambda handler so that S3 can dispatch notifications to Lambda functions. */
  public void setLambdaHandler(LambdaHandler lambdaHandler) {
    notificationOps.setLambdaHandler(lambdaHandler);
  }

  /**
   * Wires in the EventBridge handler so that S3 can dispatch notifications to EventBridge buses.
   */
  public void setEventBridgeHandler(EventBridgeHandler eventBridgeHandler) {
    notificationOps.setEventBridgeHandler(eventBridgeHandler);
  }

  /**
   * Gets an object from S3 programmatically (used by StepFunctions service task bridges). The
   * params map must contain "Bucket" and "Key" keys. Returns a map with "Body" as a byte[].
   */
  public Map<String, Object> executeGetObject(Map<String, Object> params) {
    String bucket = (String) params.get("Bucket");
    String key = (String) params.get("Key");
    Map<String, byte[]> bucketObjs = store.objects.get(bucket);
    if (bucketObjs == null || !bucketObjs.containsKey(key)) {
      throw new RuntimeException("NoSuchKey: The specified key does not exist: " + key);
    }
    byte[] data = bucketObjs.get(key);
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("Body", data);
    result.put("ContentLength", data.length);
    return result;
  }

  /**
   * Puts an object into S3 programmatically (used by StepFunctions service task bridges). The
   * params map must contain "Bucket", "Key", and "Body" keys. Returns an empty map.
   */
  public Map<String, Object> executePutObject(Map<String, Object> params) {
    String bucket = (String) params.get("Bucket");
    String key = (String) params.get("Key");
    Object bodyObj = params.get("Body");
    byte[] data;
    if (bodyObj instanceof byte[]) {
      data = (byte[]) bodyObj;
    } else if (bodyObj instanceof String) {
      data = ((String) bodyObj).getBytes(StandardCharsets.UTF_8);
    } else {
      data = new byte[0];
    }
    if (!store.buckets.containsKey(bucket)) {
      throw new RuntimeException("NoSuchBucket: The specified bucket does not exist: " + bucket);
    }
    store.objects.computeIfAbsent(bucket, k -> new ConcurrentHashMap<>()).put(key, data);
    return new LinkedHashMap<>();
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String method = exchange.getRequestMethod();
    String path = exchange.getRequestURI().getPath();
    String query = exchange.getRequestURI().getQuery();
    Map<String, String> queryParams = S3HttpHelper.parseQuery(query);

    // Parse bucket and key from path: /<bucket>/<key>
    String[] parts = path.replaceFirst("^/", "").split("/", 2);
    String bucket = parts.length > 0 ? parts[0] : "";
    String key = parts.length > 1 ? parts[1] : "";

    // Determine operation
    String operation = detectOperation(method, bucket, key, queryParams, exchange);

    try {
      if (IamMiddleware.applyIamAuth(state, "s3", operation, exchange, true)) return;
      if (ChaosMiddleware.applyChaos(state, "s3", operation, exchange, true)) return;

      handleOperation(method, bucket, key, queryParams, exchange, operation);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      S3HttpHelper.sendS3Error(exchange, 500, "ServiceUnavailable", "Interrupted");
    } catch (Exception e) {
      S3HttpHelper.sendS3Error(
          exchange, 400, "InvalidRequest", e.getMessage() != null ? e.getMessage() : "Error");
    }
  }

  private String detectOperation(
      String method,
      String bucket,
      String key,
      Map<String, String> queryParams,
      HttpExchange exchange) {
    if (bucket.isEmpty()) {
      return "GET".equals(method) ? "ListBuckets" : "Unknown";
    }
    if (key.isEmpty()) {
      if ("PUT".equals(method)) {
        if (queryParams.containsKey("tagging")) return "PutBucketTagging";
        if (queryParams.containsKey("policy")) return "PutBucketPolicy";
        if (queryParams.containsKey("notification")) return "PutBucketNotificationConfiguration";
        if (queryParams.containsKey("website")) return "PutBucketWebsite";
        if (queryParams.containsKey("versioning")) return "PutBucketVersioning";
        return "CreateBucket";
      }
      if ("DELETE".equals(method)) {
        if (queryParams.containsKey("tagging")) return "DeleteBucketTagging";
        if (queryParams.containsKey("website")) return "DeleteBucketWebsite";
        return "DeleteBucket";
      }
      if ("HEAD".equals(method)) return "HeadBucket";
      if ("GET".equals(method)) {
        if (queryParams.containsKey("list-type")) return "ListObjectsV2";
        if (queryParams.containsKey("location")) return "GetBucketLocation";
        if (queryParams.containsKey("tagging")) return "GetBucketTagging";
        if (queryParams.containsKey("policy")) return "GetBucketPolicy";
        if (queryParams.containsKey("notification")) return "GetBucketNotificationConfiguration";
        if (queryParams.containsKey("website")) return "GetBucketWebsite";
        return "ListObjectsV2";
      }
      if ("POST".equals(method)) {
        if (queryParams.containsKey("delete")) return "DeleteObjects";
      }
    } else {
      if ("GET".equals(method)) {
        if (queryParams.containsKey("uploadId") && queryParams.containsKey("partNumber"))
          return "UploadPart";
        if (queryParams.containsKey("uploadId")) return "ListParts";
        return "GetObject";
      }
      if ("PUT".equals(method)) {
        if (queryParams.containsKey("uploadId")) return "UploadPart";
        String copySource = exchange.getRequestHeaders().getFirst("X-Amz-Copy-Source");
        if (copySource != null) return "CopyObject";
        return "PutObject";
      }
      if ("DELETE".equals(method)) {
        if (queryParams.containsKey("uploadId")) return "AbortMultipartUpload";
        return "DeleteObject";
      }
      if ("HEAD".equals(method)) return "HeadObject";
      if ("POST".equals(method)) {
        if (queryParams.containsKey("uploads")) return "CreateMultipartUpload";
        if (queryParams.containsKey("uploadId")) return "CompleteMultipartUpload";
      }
    }
    return "Unknown";
  }

  @SuppressWarnings({"unchecked", "PMD.UnusedFormalParameter"})
  private void handleOperation(
      String method,
      String bucket,
      String key,
      Map<String, String> queryParams,
      HttpExchange exchange,
      String operation)
      throws IOException {
    // Delegate to specialised handlers first
    if (bucketConfigOps.handle(operation, bucket, exchange)) return;
    if (multipartOps.handle(operation, bucket, key, queryParams, exchange)) return;

    switch (operation) {
      case "ListBuckets":
        {
          StringBuilder sb =
              new StringBuilder(
                  "<?xml version=\"1.0\" encoding=\"UTF-8\"?><ListAllMyBucketsResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\"><Buckets>");
          for (String b : store.buckets.keySet()) {
            sb.append("<Bucket><Name>")
                .append(b)
                .append("</Name><CreationDate>2024-01-01T00:00:00.000Z</CreationDate></Bucket>");
          }
          sb.append(
              "</Buckets><Owner><ID>test-owner</ID><DisplayName>test</DisplayName></Owner></ListAllMyBucketsResult>");
          S3HttpHelper.sendXml(exchange, 200, sb.toString());
          break;
        }
      case "CreateBucket":
        {
          if (store.buckets.containsKey(bucket)) {
            S3HttpHelper.sendXml(
                exchange,
                409,
                "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Error><Code>BucketAlreadyOwnedByYou</Code><Message>Your previous request to create the named bucket succeeded and you already own it.</Message></Error>");
            break;
          }
          store.buckets.put(bucket, new LinkedHashMap<>(Map.of("name", bucket)));
          store.objects.put(bucket, new ConcurrentHashMap<>());
          exchange.getResponseHeaders().set("Location", "/" + bucket);
          S3HttpHelper.sendEmpty(exchange, 200);
          break;
        }
      case "DeleteBucket":
        {
          if (!store.buckets.containsKey(bucket)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
            return;
          }
          Map<String, byte[]> bucketObjs = store.objects.get(bucket);
          if (bucketObjs != null && !bucketObjs.isEmpty()) {
            S3HttpHelper.sendS3Error(
                exchange, 409, "BucketNotEmpty", "The bucket you tried to delete is not empty.");
            return;
          }
          store.buckets.remove(bucket);
          store.objects.remove(bucket);
          S3HttpHelper.sendEmpty(exchange, 204);
          break;
        }
      case "HeadBucket":
        {
          if (!store.buckets.containsKey(bucket)) {
            S3HttpHelper.sendS3Error(exchange, 404, "NoSuchBucket", "NoSuchBucket");
            return;
          }
          S3HttpHelper.sendEmpty(exchange, 200);
          break;
        }
      case "ListObjectsV2":
        {
          if (!store.buckets.containsKey(bucket)) {
            S3HttpHelper.sendS3Error(exchange, 404, "NoSuchBucket", "NoSuchBucket");
            return;
          }
          Map<String, byte[]> objs = store.objects.getOrDefault(bucket, Map.of());
          String prefix = queryParams.getOrDefault("prefix", "");
          StringBuilder sb =
              new StringBuilder(
                  "<?xml version=\"1.0\" encoding=\"UTF-8\"?><ListBucketResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
          sb.append("<Name>").append(bucket).append("</Name>");
          sb.append("<Prefix>").append(prefix).append("</Prefix>");
          sb.append("<KeyCount>").append(objs.size()).append("</KeyCount>");
          sb.append("<MaxKeys>1000</MaxKeys><IsTruncated>false</IsTruncated>");
          for (Map.Entry<String, byte[]> entry : objs.entrySet()) {
            String k = entry.getKey();
            byte[] v = entry.getValue();
            if (k.startsWith(prefix)) {
              sb.append("<Contents><Key>")
                  .append(k)
                  .append("</Key>")
                  .append("<Size>")
                  .append(v.length)
                  .append("</Size>")
                  .append("<ETag>\"")
                  .append(S3HttpHelper.md5Hex(v))
                  .append("\"</ETag>")
                  .append("<StorageClass>STANDARD</StorageClass></Contents>");
            }
          }
          sb.append("</ListBucketResult>");
          S3HttpHelper.sendXml(exchange, 200, sb.toString());
          break;
        }
      case "PutObject":
        {
          if (!store.buckets.containsKey(bucket)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
            return;
          }
          byte[] body;
          try (InputStream is = exchange.getRequestBody()) {
            body = is.readAllBytes();
          }
          body = S3HttpHelper.decodeAwsChunkedIfNeeded(exchange, body);
          store.objects.computeIfAbsent(bucket, k -> new ConcurrentHashMap<>()).put(key, body);
          exchange.getResponseHeaders().set("ETag", "\"" + S3HttpHelper.md5Hex(body) + "\"");
          S3HttpHelper.echoChecksumHeaders(exchange);
          S3HttpHelper.sendEmpty(exchange, 200);
          notificationOps.dispatchNotification(bucket, key, "ObjectCreated:Put");
          break;
        }
      case "GetObject":
        {
          Map<String, byte[]> bucketObjs = store.objects.get(bucket);
          if (bucketObjs == null || !bucketObjs.containsKey(key)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchKey", "The specified key does not exist.");
            return;
          }
          byte[] data = bucketObjs.get(key);
          exchange.getResponseHeaders().set("Content-Type", "application/octet-stream");
          exchange.getResponseHeaders().set("ETag", "\"" + S3HttpHelper.md5Hex(data) + "\"");
          exchange.sendResponseHeaders(200, data.length);
          try (OutputStream os = exchange.getResponseBody()) {
            os.write(data);
          }
          break;
        }
      case "HeadObject":
        {
          Map<String, byte[]> bucketObjs = store.objects.get(bucket);
          if (bucketObjs == null || !bucketObjs.containsKey(key)) {
            S3HttpHelper.sendS3Error(exchange, 404, "NoSuchKey", "NoSuchKey");
            return;
          }
          byte[] data = bucketObjs.get(key);
          exchange.getResponseHeaders().set("Content-Length", String.valueOf(data.length));
          exchange.getResponseHeaders().set("ETag", "\"" + S3HttpHelper.md5Hex(data) + "\"");
          exchange.sendResponseHeaders(200, -1);
          break;
        }
      case "DeleteObject":
        {
          if (!store.buckets.containsKey(bucket)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
            return;
          }
          Map<String, byte[]> bucketObjs = store.objects.get(bucket);
          if (bucketObjs == null || !bucketObjs.containsKey(key)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchKey", "The specified key does not exist.");
            return;
          }
          bucketObjs.remove(key);
          S3HttpHelper.sendEmpty(exchange, 204);
          notificationOps.dispatchNotification(bucket, key, "ObjectRemoved:Delete");
          break;
        }
      case "DeleteObjects":
        {
          byte[] body;
          try (InputStream is = exchange.getRequestBody()) {
            body = is.readAllBytes();
          }
          String bodyStr = new String(body, StandardCharsets.UTF_8);
          List<String> deletedKeys = new ArrayList<>();
          Map<String, byte[]> bucketObjs = store.objects.get(bucket);
          int idx = 0;
          while ((idx = bodyStr.indexOf("<Key>", idx)) >= 0) {
            int end = bodyStr.indexOf("</Key>", idx);
            if (end < 0) break;
            String k = bodyStr.substring(idx + 5, end);
            if (bucketObjs != null) bucketObjs.remove(k);
            deletedKeys.add(k);
            idx = end + 6;
          }
          StringBuilder sb =
              new StringBuilder(
                  "<?xml version=\"1.0\" encoding=\"UTF-8\"?><DeleteResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
          for (String k : deletedKeys)
            sb.append("<Deleted><Key>").append(k).append("</Key></Deleted>");
          sb.append("</DeleteResult>");
          S3HttpHelper.sendXml(exchange, 200, sb.toString());
          for (String k : deletedKeys) {
            notificationOps.dispatchNotification(bucket, k, "ObjectRemoved:Delete");
          }
          break;
        }
      case "CopyObject":
        {
          String copySource = exchange.getRequestHeaders().getFirst("X-Amz-Copy-Source");
          if (copySource == null) {
            S3HttpHelper.sendS3Error(
                exchange, 400, "InvalidRequest", "Missing X-Amz-Copy-Source header.");
            return;
          }
          String[] srcParts = copySource.replaceFirst("^/", "").split("/", 2);
          if (srcParts.length != 2) {
            S3HttpHelper.sendS3Error(exchange, 400, "InvalidRequest", "Invalid copy source.");
            return;
          }
          String srcBucket = srcParts[0];
          String srcKey = srcParts[1];
          if (!store.buckets.containsKey(srcBucket)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchBucket", "The specified source bucket does not exist.");
            return;
          }
          Map<String, byte[]> srcObjs = store.objects.get(srcBucket);
          if (srcObjs == null || !srcObjs.containsKey(srcKey)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchKey", "The specified source object does not exist.");
            return;
          }
          if (!store.buckets.containsKey(bucket)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchBucket", "The specified destination bucket does not exist.");
            return;
          }
          byte[] data = srcObjs.get(srcKey);
          store.objects.computeIfAbsent(bucket, b -> new ConcurrentHashMap<>()).put(key, data);
          String copyEtag = S3HttpHelper.md5Hex(data);
          String xml =
              "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CopyObjectResult><ETag>\""
                  + copyEtag
                  + "\"</ETag><LastModified>2024-01-01T00:00:00.000Z</LastModified></CopyObjectResult>";
          S3HttpHelper.sendXml(exchange, 200, xml);
          notificationOps.dispatchNotification(bucket, key, "ObjectCreated:Copy");
          break;
        }
      default:
        {
          S3HttpHelper.sendXml(
              exchange,
              400,
              "<?xml version=\"1.0\"?><Error><Code>NotImplemented</Code><Message>Operation "
                  + operation
                  + " not implemented</Message></Error>");
        }
    }
  }
}
