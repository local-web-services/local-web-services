package io.localwebservices.lws.providers.s3;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** S3 wire-protocol HTTP handler. */
public class S3Handler implements HttpHandler {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    // Simple in-memory S3 store
    private final Map<String, Map<String, Object>> buckets = new ConcurrentHashMap<>();
    private final Map<String, Map<String, byte[]>> objects = new ConcurrentHashMap<>();
    private final Map<String, Map<String, String>> objectMetadata = new ConcurrentHashMap<>();
    private final Map<String, Map<String, String>> bucketTags = new ConcurrentHashMap<>();
    private final Map<String, String> bucketPolicies = new ConcurrentHashMap<>();
    private final Map<String, Map<String, String>> bucketWebsites = new ConcurrentHashMap<>();
    private final Map<String, Map<String, Object>> multipartUploads = new ConcurrentHashMap<>();
    private final Map<String, Map<Integer, byte[]>> multipartParts = new ConcurrentHashMap<>();

    private final ServerState state;

    public S3Handler(ServerState state) {
        this.state = state;
        state.resetCallbacks.add(this::reset);
    }

    private void reset() {
        buckets.clear();
        objects.clear();
        objectMetadata.clear();
        bucketTags.clear();
        bucketPolicies.clear();
        bucketWebsites.clear();
        multipartUploads.clear();
        multipartParts.clear();
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        String method = exchange.getRequestMethod();
        String path = exchange.getRequestURI().getPath();
        String query = exchange.getRequestURI().getQuery();
        Map<String, String> queryParams = parseQuery(query);

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
            sendS3Error(exchange, 500, "ServiceUnavailable", "Interrupted");
        } catch (Exception e) {
            sendS3Error(exchange, 400, "InvalidRequest", e.getMessage() != null ? e.getMessage() : "Error");
        }
    }

    private String detectOperation(String method, String bucket, String key, Map<String, String> queryParams, HttpExchange exchange) {
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
                if (queryParams.containsKey("uploadId") && queryParams.containsKey("partNumber")) return "UploadPart";
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

    @SuppressWarnings("unchecked")
    private void handleOperation(String method, String bucket, String key, Map<String, String> queryParams,
                                   HttpExchange exchange, String operation) throws IOException {
        switch (operation) {
            case "ListBuckets": {
                StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"UTF-8\"?><ListAllMyBucketsResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\"><Buckets>");
                for (String b : buckets.keySet()) {
                    sb.append("<Bucket><Name>").append(b).append("</Name><CreationDate>2024-01-01T00:00:00.000Z</CreationDate></Bucket>");
                }
                sb.append("</Buckets><Owner><ID>test-owner</ID><DisplayName>test</DisplayName></Owner></ListAllMyBucketsResult>");
                sendXml(exchange, 200, sb.toString());
                break;
            }
            case "CreateBucket": {
                if (buckets.containsKey(bucket)) {
                    sendXml(exchange, 409, "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Error><Code>BucketAlreadyOwnedByYou</Code><Message>Your previous request to create the named bucket succeeded and you already own it.</Message></Error>");
                    break;
                }
                buckets.put(bucket, new LinkedHashMap<>(Map.of("name", bucket)));
                objects.put(bucket, new ConcurrentHashMap<>());
                exchange.getResponseHeaders().set("Location", "/" + bucket);
                sendEmpty(exchange, 200);
                break;
            }
            case "DeleteBucket": {
                if (!buckets.containsKey(bucket)) {
                    sendS3Error(exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
                    return;
                }
                Map<String, byte[]> bucketObjs = objects.get(bucket);
                if (bucketObjs != null && !bucketObjs.isEmpty()) {
                    sendS3Error(exchange, 409, "BucketNotEmpty", "The bucket you tried to delete is not empty.");
                    return;
                }
                buckets.remove(bucket);
                objects.remove(bucket);
                sendEmpty(exchange, 204);
                break;
            }
            case "HeadBucket": {
                if (!buckets.containsKey(bucket)) { sendS3Error(exchange, 404, "NoSuchBucket", "NoSuchBucket"); return; }
                sendEmpty(exchange, 200);
                break;
            }
            case "ListObjectsV2": {
                if (!buckets.containsKey(bucket)) { sendS3Error(exchange, 404, "NoSuchBucket", "NoSuchBucket"); return; }
                Map<String, byte[]> objs = objects.getOrDefault(bucket, Map.of());
                String prefix = queryParams.getOrDefault("prefix", "");
                StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"UTF-8\"?><ListBucketResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
                sb.append("<Name>").append(bucket).append("</Name>");
                sb.append("<Prefix>").append(prefix).append("</Prefix>");
                sb.append("<KeyCount>").append(objs.size()).append("</KeyCount>");
                sb.append("<MaxKeys>1000</MaxKeys><IsTruncated>false</IsTruncated>");
                for (String k : objs.keySet()) {
                    if (k.startsWith(prefix)) {
                        sb.append("<Contents><Key>").append(k).append("</Key>")
                          .append("<Size>").append(objs.get(k).length).append("</Size>")
                          .append("<ETag>\"").append(md5Hex(objs.get(k))).append("\"</ETag>")
                          .append("<StorageClass>STANDARD</StorageClass></Contents>");
                    }
                }
                sb.append("</ListBucketResult>");
                sendXml(exchange, 200, sb.toString());
                break;
            }
            case "PutObject": {
                if (!buckets.containsKey(bucket)) {
                    sendS3Error(exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
                    return;
                }
                byte[] body;
                try (InputStream is = exchange.getRequestBody()) { body = is.readAllBytes(); }
                body = decodeAwsChunkedIfNeeded(exchange, body);
                objects.computeIfAbsent(bucket, k -> new ConcurrentHashMap<>()).put(key, body);
                exchange.getResponseHeaders().set("ETag", "\"" + md5Hex(body) + "\"");
                echoChecksumHeaders(exchange);
                sendEmpty(exchange, 200);
                break;
            }
            case "GetObject": {
                Map<String, byte[]> bucketObjs = objects.get(bucket);
                if (bucketObjs == null || !bucketObjs.containsKey(key)) {
                    sendS3Error(exchange, 404, "NoSuchKey", "The specified key does not exist.");
                    return;
                }
                byte[] data = bucketObjs.get(key);
                exchange.getResponseHeaders().set("Content-Type", "application/octet-stream");
                exchange.getResponseHeaders().set("ETag", "\"" + md5Hex(data) + "\"");
                exchange.sendResponseHeaders(200, data.length);
                try (OutputStream os = exchange.getResponseBody()) { os.write(data); }
                break;
            }
            case "HeadObject": {
                Map<String, byte[]> bucketObjs = objects.get(bucket);
                if (bucketObjs == null || !bucketObjs.containsKey(key)) {
                    sendS3Error(exchange, 404, "NoSuchKey", "NoSuchKey");
                    return;
                }
                byte[] data = bucketObjs.get(key);
                exchange.getResponseHeaders().set("Content-Length", String.valueOf(data.length));
                exchange.getResponseHeaders().set("ETag", "\"" + md5Hex(data) + "\"");
                exchange.sendResponseHeaders(200, -1);
                break;
            }
            case "DeleteObject": {
                if (!buckets.containsKey(bucket)) {
                    sendS3Error(exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
                    return;
                }
                Map<String, byte[]> bucketObjs = objects.get(bucket);
                if (bucketObjs == null || !bucketObjs.containsKey(key)) {
                    sendS3Error(exchange, 404, "NoSuchKey", "The specified key does not exist.");
                    return;
                }
                bucketObjs.remove(key);
                sendEmpty(exchange, 204);
                break;
            }
            case "DeleteObjects": {
                byte[] body;
                try (InputStream is = exchange.getRequestBody()) { body = is.readAllBytes(); }
                // Parse keys from XML body (simple)
                String bodyStr = new String(body, StandardCharsets.UTF_8);
                List<String> deletedKeys = new ArrayList<>();
                Map<String, byte[]> bucketObjs = objects.get(bucket);
                int idx = 0;
                while ((idx = bodyStr.indexOf("<Key>", idx)) >= 0) {
                    int end = bodyStr.indexOf("</Key>", idx);
                    if (end < 0) break;
                    String k = bodyStr.substring(idx + 5, end);
                    if (bucketObjs != null) bucketObjs.remove(k);
                    deletedKeys.add(k);
                    idx = end + 6;
                }
                StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"UTF-8\"?><DeleteResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
                for (String k : deletedKeys) sb.append("<Deleted><Key>").append(k).append("</Key></Deleted>");
                sb.append("</DeleteResult>");
                sendXml(exchange, 200, sb.toString());
                break;
            }
            case "CopyObject": {
                String copySource = exchange.getRequestHeaders().getFirst("X-Amz-Copy-Source");
                if (copySource == null) {
                    sendS3Error(exchange, 400, "InvalidRequest", "Missing X-Amz-Copy-Source header.");
                    return;
                }
                String[] srcParts = copySource.replaceFirst("^/", "").split("/", 2);
                if (srcParts.length != 2) {
                    sendS3Error(exchange, 400, "InvalidRequest", "Invalid copy source.");
                    return;
                }
                String srcBucket = srcParts[0];
                String srcKey = srcParts[1];
                // Validate source bucket exists
                if (!buckets.containsKey(srcBucket)) {
                    sendS3Error(exchange, 404, "NoSuchBucket", "The specified source bucket does not exist.");
                    return;
                }
                // Validate source object exists
                Map<String, byte[]> srcObjs = objects.get(srcBucket);
                if (srcObjs == null || !srcObjs.containsKey(srcKey)) {
                    sendS3Error(exchange, 404, "NoSuchKey", "The specified source object does not exist.");
                    return;
                }
                // Validate destination bucket exists
                if (!buckets.containsKey(bucket)) {
                    sendS3Error(exchange, 404, "NoSuchBucket", "The specified destination bucket does not exist.");
                    return;
                }
                byte[] data = srcObjs.get(srcKey);
                objects.computeIfAbsent(bucket, b -> new ConcurrentHashMap<>()).put(key, data);
                String copyEtag = md5Hex(data);
                String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CopyObjectResult><ETag>\"" + copyEtag + "\"</ETag><LastModified>2024-01-01T00:00:00.000Z</LastModified></CopyObjectResult>";
                sendXml(exchange, 200, xml);
                break;
            }
            case "GetBucketLocation": {
                sendXml(exchange, 200, "<?xml version=\"1.0\" encoding=\"UTF-8\"?><LocationConstraint xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">us-east-1</LocationConstraint>");
                break;
            }
            case "GetBucketTagging": {
                Map<String, String> tags = bucketTags.getOrDefault(bucket, Map.of());
                StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"UTF-8\"?><Tagging xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\"><TagSet>");
                for (Map.Entry<String, String> e : tags.entrySet()) {
                    sb.append("<Tag><Key>").append(e.getKey()).append("</Key><Value>").append(e.getValue()).append("</Value></Tag>");
                }
                sb.append("</TagSet></Tagging>");
                sendXml(exchange, 200, sb.toString());
                break;
            }
            case "PutBucketVersioning": {
                if (!buckets.containsKey(bucket)) {
                    sendS3Error(exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
                    return;
                }
                sendEmpty(exchange, 200);
                break;
            }
            case "PutBucketTagging": {
                sendEmpty(exchange, 200);
                break;
            }
            case "DeleteBucketTagging": {
                bucketTags.remove(bucket);
                sendEmpty(exchange, 204);
                break;
            }
            case "GetBucketPolicy": {
                String policy = bucketPolicies.get(bucket);
                if (policy == null) { sendS3Error(exchange, 404, "NoSuchBucketPolicy", "No policy"); return; }
                byte[] bytes = policy.getBytes(StandardCharsets.UTF_8);
                exchange.getResponseHeaders().set("Content-Type", "application/json");
                exchange.sendResponseHeaders(200, bytes.length);
                try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
                break;
            }
            case "PutBucketPolicy": {
                byte[] body;
                try (InputStream is = exchange.getRequestBody()) { body = is.readAllBytes(); }
                bucketPolicies.put(bucket, new String(body, StandardCharsets.UTF_8));
                sendEmpty(exchange, 200);
                break;
            }
            case "GetBucketNotificationConfiguration": {
                sendXml(exchange, 200, "<?xml version=\"1.0\" encoding=\"UTF-8\"?><NotificationConfiguration xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\"></NotificationConfiguration>");
                break;
            }
            case "PutBucketNotificationConfiguration": {
                sendEmpty(exchange, 200);
                break;
            }
            case "GetBucketWebsite": {
                Map<String, String> webCfg = bucketWebsites.get(bucket);
                if (webCfg == null) {
                    sendS3Error(exchange, 404, "NoSuchWebsiteConfiguration", "The specified bucket does not have a website configuration");
                    return;
                }
                String indexSuffix = webCfg.getOrDefault("indexSuffix", "index.html");
                String errorKey = webCfg.getOrDefault("errorKey", "error.html");
                String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><WebsiteConfiguration xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">" +
                    "<IndexDocument><Suffix>" + indexSuffix + "</Suffix></IndexDocument>" +
                    "<ErrorDocument><Key>" + errorKey + "</Key></ErrorDocument>" +
                    "</WebsiteConfiguration>";
                sendXml(exchange, 200, xml);
                break;
            }
            case "PutBucketWebsite": {
                byte[] body;
                try (InputStream is = exchange.getRequestBody()) { body = is.readAllBytes(); }
                String bodyStr = new String(body, StandardCharsets.UTF_8);
                Map<String, String> webCfg = new LinkedHashMap<>();
                // Parse IndexDocument Suffix
                int suffixStart = bodyStr.indexOf("<Suffix>");
                int suffixEnd = bodyStr.indexOf("</Suffix>");
                if (suffixStart >= 0 && suffixEnd > suffixStart) {
                    webCfg.put("indexSuffix", bodyStr.substring(suffixStart + 8, suffixEnd));
                } else {
                    webCfg.put("indexSuffix", "index.html");
                }
                // Parse ErrorDocument Key
                int errStart = bodyStr.indexOf("<Key>");
                int errEnd = bodyStr.indexOf("</Key>");
                if (errStart >= 0 && errEnd > errStart) {
                    webCfg.put("errorKey", bodyStr.substring(errStart + 5, errEnd));
                } else {
                    webCfg.put("errorKey", "error.html");
                }
                bucketWebsites.put(bucket, webCfg);
                sendEmpty(exchange, 200);
                break;
            }
            case "DeleteBucketWebsite": {
                bucketWebsites.remove(bucket);
                sendEmpty(exchange, 204);
                break;
            }
            case "CreateMultipartUpload": {
                if (!buckets.containsKey(bucket)) {
                    sendS3Error(exchange, 404, "NoSuchBucket", "The specified bucket does not exist.");
                    return;
                }
                // Check if an upload already exists for this bucket+key
                String bucketKey = bucket + "/" + key;
                boolean alreadyExists = multipartUploads.values().stream()
                    .anyMatch(u -> bucketKey.equals(u.get("bucket") + "/" + u.get("key")));
                if (alreadyExists) {
                    sendS3Error(exchange, 409, "MultipartUploadAlreadyExists", "A multipart upload already exists for this key.");
                    return;
                }
                String uploadId = UUID.randomUUID().toString();
                multipartUploads.put(uploadId, new LinkedHashMap<>(Map.of("bucket", bucket, "key", key)));
                multipartParts.put(uploadId, new ConcurrentHashMap<>());
                String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><InitiateMultipartUploadResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">" +
                    "<Bucket>" + bucket + "</Bucket><Key>" + key + "</Key><UploadId>" + uploadId + "</UploadId></InitiateMultipartUploadResult>";
                sendXml(exchange, 200, xml);
                break;
            }
            case "UploadPart": {
                String uploadId = queryParams.getOrDefault("uploadId", "dummy");
                int partNumber = Integer.parseInt(queryParams.getOrDefault("partNumber", "1"));
                byte[] body;
                try (InputStream is = exchange.getRequestBody()) { body = is.readAllBytes(); }
                body = decodeAwsChunkedIfNeeded(exchange, body);
                multipartParts.computeIfAbsent(uploadId, k -> new ConcurrentHashMap<>()).put(partNumber, body);
                exchange.getResponseHeaders().set("ETag", "\"" + md5Hex(body) + "\"");
                sendEmpty(exchange, 200);
                break;
            }
            case "CompleteMultipartUpload": {
                String uploadId = queryParams.get("uploadId");
                if (uploadId == null || !multipartUploads.containsKey(uploadId)) {
                    sendS3Error(exchange, 404, "NoSuchUpload", "The specified upload does not exist.");
                    return;
                }
                Map<Integer, byte[]> parts = multipartParts.getOrDefault(uploadId, Map.of());
                if (parts.isEmpty()) {
                    sendS3Error(exchange, 400, "MalformedXML", "The upload must have at least one part.");
                    return;
                }
                // Combine parts
                List<Integer> sortedParts = new ArrayList<>(parts.keySet());
                Collections.sort(sortedParts);
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                for (int partNum : sortedParts) {
                    baos.write(parts.get(partNum));
                }
                objects.computeIfAbsent(bucket, b -> new ConcurrentHashMap<>()).put(key, baos.toByteArray());
                multipartUploads.remove(uploadId);
                multipartParts.remove(uploadId);
                String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CompleteMultipartUploadResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">" +
                    "<Location>http://127.0.0.1/" + bucket + "/" + key + "</Location>" +
                    "<Bucket>" + bucket + "</Bucket><Key>" + key + "</Key><ETag>\"combined-etag\"</ETag></CompleteMultipartUploadResult>";
                sendXml(exchange, 200, xml);
                break;
            }
            case "AbortMultipartUpload": {
                String uploadId = queryParams.getOrDefault("uploadId", "dummy");
                multipartUploads.remove(uploadId);
                multipartParts.remove(uploadId);
                sendEmpty(exchange, 204);
                break;
            }
            case "ListParts": {
                String uploadId = queryParams.getOrDefault("uploadId", "dummy");
                Map<Integer, byte[]> parts = multipartParts.getOrDefault(uploadId, Map.of());
                StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"UTF-8\"?><ListPartsResult xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
                sb.append("<Bucket>").append(bucket).append("</Bucket><Key>").append(key).append("</Key>");
                sb.append("<UploadId>").append(uploadId).append("</UploadId><IsTruncated>false</IsTruncated>");
                for (Map.Entry<Integer, byte[]> e : parts.entrySet()) {
                    sb.append("<Part><PartNumber>").append(e.getKey()).append("</PartNumber><ETag>\"").append(md5Hex(e.getValue())).append("\"</ETag><Size>").append(e.getValue().length).append("</Size></Part>");
                }
                sb.append("</ListPartsResult>");
                sendXml(exchange, 200, sb.toString());
                break;
            }
            default: {
                sendXml(exchange, 400, "<?xml version=\"1.0\"?><Error><Code>NotImplemented</Code><Message>Operation " + operation + " not implemented</Message></Error>");
            }
        }
    }

    /**
     * Decodes AWS-chunked transfer encoding if present.
     * AWS SDK v2 uses "aws-chunked" encoding with chunk signatures when content-sha256 is STREAMING-*
     * Format: <hex-size>;chunk-signature=<sig>\r\n<data>\r\n...\r\n0;chunk-signature=<sig>\r\n\r\n
     */
    private static byte[] decodeAwsChunkedIfNeeded(HttpExchange exchange, byte[] body) {
        String contentEncoding = exchange.getRequestHeaders().getFirst("Content-Encoding");
        String contentSha256 = exchange.getRequestHeaders().getFirst("x-amz-content-sha256");
        boolean isAwsChunked = "aws-chunked".equals(contentEncoding)
            || (contentSha256 != null && contentSha256.startsWith("STREAMING-"));
        if (!isAwsChunked) return body;

        try {
            ByteArrayOutputStream decoded = new ByteArrayOutputStream();
            int i = 0;
            String text = new String(body, StandardCharsets.ISO_8859_1);
            while (i < text.length()) {
                // Find end of chunk size line
                int lineEnd = text.indexOf("\r\n", i);
                if (lineEnd < 0) break;
                String sizeLine = text.substring(i, lineEnd);
                // size might have ;chunk-signature=... appended
                int semiColon = sizeLine.indexOf(';');
                String hexSize = semiColon >= 0 ? sizeLine.substring(0, semiColon) : sizeLine;
                hexSize = hexSize.trim();
                if (hexSize.isEmpty()) { i = lineEnd + 2; continue; }
                int chunkSize;
                try { chunkSize = Integer.parseInt(hexSize, 16); } catch (NumberFormatException e) { break; }
                if (chunkSize == 0) break;
                i = lineEnd + 2; // skip \r\n after size line
                // Write chunk data
                byte[] chunk = new String(body, i, chunkSize, StandardCharsets.ISO_8859_1)
                    .getBytes(StandardCharsets.ISO_8859_1);
                decoded.write(chunk);
                i += chunkSize + 2; // skip data + \r\n
            }
            return decoded.toByteArray();
        } catch (Exception e) {
            return body; // Return original if parsing fails
        }
    }

    private static void echoChecksumHeaders(HttpExchange exchange) {
        // Echo back any checksum headers sent by the SDK so validation passes
        String[] checksumHeaders = {
            "x-amz-checksum-crc32", "x-amz-checksum-crc32c", "x-amz-checksum-sha1", "x-amz-checksum-sha256"
        };
        for (String header : checksumHeaders) {
            String value = exchange.getRequestHeaders().getFirst(header);
            if (value != null) {
                exchange.getResponseHeaders().set(header, value);
            }
        }
    }

    private static String md5Hex(byte[] data) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(data);
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) {
            return "d41d8cd98f00b204e9800998ecf8427e";
        }
    }

    private void sendXml(HttpExchange exchange, int status, String xml) throws IOException {
        byte[] bytes = xml.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", "application/xml");
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
    }

    private void sendEmpty(HttpExchange exchange, int status) throws IOException {
        exchange.sendResponseHeaders(status, -1);
    }

    private void sendS3Error(HttpExchange exchange, int status, String code, String message) throws IOException {
        String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Error><Code>" + code + "</Code><Message>" + message + "</Message></Error>";
        sendXml(exchange, status, xml);
    }

    private Map<String, String> parseQuery(String query) {
        Map<String, String> result = new LinkedHashMap<>();
        if (query == null || query.isEmpty()) return result;
        for (String pair : query.split("&")) {
            String[] kv = pair.split("=", 2);
            result.put(kv[0], kv.length > 1 ? kv[1] : "");
        }
        return result;
    }
}
