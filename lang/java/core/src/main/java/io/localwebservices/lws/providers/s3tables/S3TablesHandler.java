package io.localwebservices.lws.providers.s3tables;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.time.Instant;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** S3 Tables wire-protocol HTTP handler (REST JSON). */
public class S3TablesHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final ServerState state;
  // bucketName -> bucket metadata
  private final Map<String, Map<String, Object>> tableBuckets = new ConcurrentHashMap<>();
  // bucketName -> namespaceName -> namespace metadata
  private final Map<String, Map<String, Map<String, Object>>> namespaces =
      new ConcurrentHashMap<>();
  // bucketName -> namespace/tableName -> table metadata
  private final Map<String, Map<String, Map<String, Object>>> tables = new ConcurrentHashMap<>();

  public S3TablesHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(this::reset);
  }

  private void reset() {
    tableBuckets.clear();
    namespaces.clear();
    tables.clear();
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String method = exchange.getRequestMethod();
    String path = exchange.getRequestURI().getPath();
    // path: /buckets[/{bucket}[/namespaces[/{namespace}]][/tables[/{namespace}/{table}]]]
    String[] segments = path.split("/");
    // segments[0]="", segments[1]="buckets", ...

    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }

    try {
      String operation = inferOperation(method, segments);
      if (IamMiddleware.applyIamAuth(state, "s3tables", operation, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "s3tables", operation, exchange, false)) return;

      route(method, segments, bodyBytes, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendJson(exchange, 500, Map.of("message", "Interrupted"));
    } catch (Exception e) {
      sendJson(exchange, 400, Map.of("message", e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  private String inferOperation(String method, String[] segments) {
    int len = segments.length;
    // /buckets/{bucket}/namespaces/{namespace}
    if (len >= 5 && "namespaces".equals(segments[3])) {
      if (len >= 6) return "DELETE".equals(method) ? "DeleteNamespace" : "GetNamespace";
      return "POST".equals(method) ? "CreateNamespace" : "ListNamespaces";
    }
    // /buckets/{bucket}/tables/{namespace}/{table}
    if (len >= 5 && "tables".equals(segments[3])) {
      if (len >= 6) return "DELETE".equals(method) ? "DeleteTable" : "GetTable";
      return "POST".equals(method) ? "CreateTable" : "ListTables";
    }
    // /buckets/{bucket}
    if (len >= 3 && !"buckets".equals(segments[2])) {
      if ("POST".equals(method)) return "CreateBucket";
      if ("DELETE".equals(method)) return "DeleteTableBucket";
      return "GetTableBucket";
    }
    // /buckets
    return "POST".equals(method) ? "CreateTableBucket" : "ListTableBuckets";
  }

  @SuppressWarnings("unchecked")
  private void route(String method, String[] segments, byte[] bodyBytes, HttpExchange exchange)
      throws IOException {
    int len = segments.length;
    // segments: ["", "buckets", ...]
    String bucketName = len >= 3 ? segments[2] : null;

    // /buckets/{bucket}/namespaces[/{namespace}]
    if (bucketName != null && len >= 4 && "namespaces".equals(segments[3])) {
      String nsName = len >= 5 ? segments[4] : null;
      if ("POST".equals(method) && nsName == null) {
        // CreateNamespace
        Map<String, Object> body =
            bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
        Object nsObj = body.get("namespace");
        String ns = nsObj instanceof List ? (String) ((List<?>) nsObj).get(0) : (String) nsObj;
        Map<String, Object> namespace = new LinkedHashMap<>();
        namespace.put("Namespace", List.of(ns));
        namespace.put("TableBucketName", bucketName);
        namespace.put("CreatedAt", Instant.now().toString());
        namespace.put("OwnerAccountId", ACCOUNT);
        namespaces.computeIfAbsent(bucketName, k -> new ConcurrentHashMap<>()).put(ns, namespace);
        sendJson(exchange, 200, namespace);
        return;
      }
      if ("DELETE".equals(method) && nsName != null) {
        namespaces.getOrDefault(bucketName, new ConcurrentHashMap<>()).remove(nsName);
        exchange.sendResponseHeaders(204, -1);
        return;
      }
      if ("GET".equals(method) && nsName == null) {
        // ListNamespaces
        List<Map<String, Object>> nsList =
            new ArrayList<>(
                namespaces.getOrDefault(bucketName, new ConcurrentHashMap<>()).values());
        sendJson(exchange, 200, Map.of("Namespaces", nsList));
        return;
      }
    }

    // /buckets/{bucket}/tables[/{namespace}/{table}]
    if (bucketName != null && len >= 4 && "tables".equals(segments[3])) {
      String nsName = len >= 5 ? segments[4] : null;
      String tableName = len >= 6 ? segments[5] : null;

      if ("POST".equals(method) && nsName == null) {
        // CreateTable
        Map<String, Object> body =
            bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
        String ns = (String) body.get("namespace");
        String tName = (String) body.get("name");
        String tableKey = ns + "/" + tName;
        Map<String, Object> table = new LinkedHashMap<>();
        table.put("Name", tName);
        table.put("Namespace", ns);
        table.put("Type", "customer");
        table.put(
            "TableArn",
            "arn:aws:s3tables:"
                + REGION
                + ":"
                + ACCOUNT
                + ":bucket/"
                + bucketName
                + "/table/"
                + tableKey);
        table.put("CreatedAt", Instant.now().toString());
        table.put("ModifiedAt", Instant.now().toString());
        tables.computeIfAbsent(bucketName, k -> new ConcurrentHashMap<>()).put(tableKey, table);
        sendJson(exchange, 200, table);
        return;
      }
      if ("DELETE".equals(method) && nsName != null && tableName != null) {
        tables.getOrDefault(bucketName, new ConcurrentHashMap<>()).remove(nsName + "/" + tableName);
        exchange.sendResponseHeaders(204, -1);
        return;
      }
      if ("GET".equals(method) && nsName != null && tableName != null) {
        // GetTable
        Map<String, Object> table =
            tables
                .getOrDefault(bucketName, new ConcurrentHashMap<>())
                .get(nsName + "/" + tableName);
        if (table == null) {
          sendJson(
              exchange, 404, Map.of("message", "Table not found: " + nsName + "/" + tableName));
          return;
        }
        sendJson(exchange, 200, table);
        return;
      }
      if ("GET".equals(method) && nsName == null) {
        // ListTables
        List<Map<String, Object>> tableList =
            new ArrayList<>(tables.getOrDefault(bucketName, new ConcurrentHashMap<>()).values());
        sendJson(exchange, 200, Map.of("Tables", tableList, "ContinuationToken", (Object) null));
        return;
      }
    }

    // /buckets/{bucket}
    if (bucketName != null && len == 3) {
      if ("POST".equals(method)) {
        // CreateTableBucket
        Map<String, Object> body =
            bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
        String bName = (String) body.getOrDefault("name", bucketName);
        Map<String, Object> bucket = new LinkedHashMap<>();
        bucket.put("Name", bName);
        bucket.put("Arn", "arn:aws:s3tables:" + REGION + ":" + ACCOUNT + ":bucket/" + bName);
        bucket.put("CreatedAt", Instant.now().toString());
        bucket.put("OwnerAccountId", ACCOUNT);
        tableBuckets.put(bName, bucket);
        sendJson(exchange, 200, Map.of("TableBucket", bucket));
        return;
      }
      if ("DELETE".equals(method)) {
        tableBuckets.remove(bucketName);
        exchange.sendResponseHeaders(204, -1);
        return;
      }
      if ("GET".equals(method)) {
        Map<String, Object> bucket = tableBuckets.get(bucketName);
        if (bucket == null) {
          sendJson(exchange, 404, Map.of("message", "TableBucket not found: " + bucketName));
          return;
        }
        sendJson(exchange, 200, bucket);
        return;
      }
    }

    // /buckets
    if (len <= 2) {
      if ("POST".equals(method)) {
        // CreateTableBucket from body
        Map<String, Object> body =
            bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
        String bName = (String) body.get("name");
        Map<String, Object> bucket = new LinkedHashMap<>();
        bucket.put("Name", bName);
        bucket.put("Arn", "arn:aws:s3tables:" + REGION + ":" + ACCOUNT + ":bucket/" + bName);
        bucket.put("CreatedAt", Instant.now().toString());
        bucket.put("OwnerAccountId", ACCOUNT);
        tableBuckets.put(bName, bucket);
        sendJson(exchange, 200, Map.of("TableBucket", bucket));
        return;
      }
      if ("GET".equals(method)) {
        // ListTableBuckets
        List<Map<String, Object>> bucketList = new ArrayList<>(tableBuckets.values());
        sendJson(
            exchange, 200, Map.of("TableBuckets", bucketList, "ContinuationToken", (Object) null));
        return;
      }
    }

    sendJson(
        exchange,
        400,
        Map.of("message", "Unknown operation for " + method + " " + String.join("/", segments)));
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/json");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
