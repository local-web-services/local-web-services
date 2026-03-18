package io.localwebservices.lws.providers.s3;

import com.sun.net.httpserver.HttpExchange;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** Handles S3 multipart upload operations. */
class S3MultipartOps {

  private final S3Store store;

  S3MultipartOps(S3Store store) {
    this.store = store;
  }

  /** Returns true if the operation was handled. */
  boolean handle(
      String operation,
      String bucket,
      String key,
      Map<String, String> queryParams,
      HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateMultipartUpload":
        {
          if (!store.buckets.containsKey(bucket)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
            return true;
          }
          String bucketKey = bucket + "/" + key;
          boolean alreadyExists =
              store.multipartUploads.values().stream()
                  .anyMatch(u -> bucketKey.equals(u.get("bucket") + "/" + u.get("key")));
          if (alreadyExists) {
            S3HttpHelper.sendS3Error(
                exchange,
                409,
                "MultipartUploadAlreadyExists",
                "A multipart upload already exists for this key.");
            return true;
          }
          String uploadId = UUID.randomUUID().toString();
          store.multipartUploads.put(
              uploadId, new LinkedHashMap<>(Map.of("bucket", bucket, "key", key)));
          store.multipartParts.put(uploadId, new ConcurrentHashMap<>());
          String xml =
              "<?xml version=\"1.0\" encoding=\"UTF-8\"?><InitiateMultipartUploadResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">"
                  + "<Bucket>"
                  + bucket
                  + "</Bucket><Key>"
                  + key
                  + "</Key><UploadId>"
                  + uploadId
                  + "</UploadId></InitiateMultipartUploadResult>";
          S3HttpHelper.sendXml(exchange, 200, xml);
          return true;
        }
      case "UploadPart":
        {
          String uploadId = queryParams.getOrDefault("uploadId", "dummy");
          int partNumber = Integer.parseInt(queryParams.getOrDefault("partNumber", "1"));
          byte[] body;
          try (InputStream is = exchange.getRequestBody()) {
            body = is.readAllBytes();
          }
          body = S3HttpHelper.decodeAwsChunkedIfNeeded(exchange, body);
          store
              .multipartParts
              .computeIfAbsent(uploadId, k -> new ConcurrentHashMap<>())
              .put(partNumber, body);
          exchange.getResponseHeaders().set("ETag", "\"" + S3HttpHelper.md5Hex(body) + "\"");
          S3HttpHelper.sendEmpty(exchange, 200);
          return true;
        }
      case "CompleteMultipartUpload":
        {
          String uploadId = queryParams.get("uploadId");
          if (uploadId == null || !store.multipartUploads.containsKey(uploadId)) {
            S3HttpHelper.sendS3Error(
                exchange, 404, "NoSuchUpload", "The specified upload does not exist.");
            return true;
          }
          Map<Integer, byte[]> parts = store.multipartParts.getOrDefault(uploadId, Map.of());
          if (parts.isEmpty()) {
            S3HttpHelper.sendS3Error(
                exchange, 400, "MalformedXML", "The upload must have at least one part.");
            return true;
          }
          List<Integer> sortedParts = new ArrayList<>(parts.keySet());
          Collections.sort(sortedParts);
          ByteArrayOutputStream baos = new ByteArrayOutputStream();
          for (int partNum : sortedParts) {
            baos.write(parts.get(partNum));
          }
          store
              .objects
              .computeIfAbsent(bucket, b -> new ConcurrentHashMap<>())
              .put(key, baos.toByteArray());
          store.multipartUploads.remove(uploadId);
          store.multipartParts.remove(uploadId);
          String xml =
              "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CompleteMultipartUploadResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">"
                  + "<Location>http://127.0.0.1/"
                  + bucket
                  + "/"
                  + key
                  + "</Location>"
                  + "<Bucket>"
                  + bucket
                  + "</Bucket><Key>"
                  + key
                  + "</Key><ETag>\"combined-etag\"</ETag></CompleteMultipartUploadResult>";
          S3HttpHelper.sendXml(exchange, 200, xml);
          return true;
        }
      case "AbortMultipartUpload":
        {
          String uploadId = queryParams.getOrDefault("uploadId", "dummy");
          store.multipartUploads.remove(uploadId);
          store.multipartParts.remove(uploadId);
          S3HttpHelper.sendEmpty(exchange, 204);
          return true;
        }
      case "ListParts":
        {
          String uploadId = queryParams.getOrDefault("uploadId", "dummy");
          Map<Integer, byte[]> parts = store.multipartParts.getOrDefault(uploadId, Map.of());
          StringBuilder sb =
              new StringBuilder(
                  "<?xml version=\"1.0\" encoding=\"UTF-8\"?><ListPartsResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
          sb.append("<Bucket>")
              .append(bucket)
              .append("</Bucket><Key>")
              .append(key)
              .append("</Key>");
          sb.append("<UploadId>")
              .append(uploadId)
              .append("</UploadId><IsTruncated>false</IsTruncated>");
          for (Map.Entry<Integer, byte[]> e : parts.entrySet()) {
            sb.append("<Part><PartNumber>")
                .append(e.getKey())
                .append("</PartNumber><ETag>\"")
                .append(S3HttpHelper.md5Hex(e.getValue()))
                .append("\"</ETag><Size>")
                .append(e.getValue().length)
                .append("</Size></Part>");
          }
          sb.append("</ListPartsResult>");
          S3HttpHelper.sendXml(exchange, 200, sb.toString());
          return true;
        }
      default:
        return false;
    }
  }
}
