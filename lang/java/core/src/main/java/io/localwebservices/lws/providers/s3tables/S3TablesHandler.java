package io.localwebservices.lws.providers.s3tables;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** S3 Tables wire-protocol HTTP handler (REST JSON). */
public class S3TablesHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final ServerState state;
  // bucketArn -> bucket metadata
  private final Map<String, Map<String, Object>> tableBuckets = new ConcurrentHashMap<>();
  // bucketArn -> namespaceName -> namespace metadata
  private final Map<String, Map<String, Map<String, Object>>> namespaces =
      new ConcurrentHashMap<>();
  // bucketArn -> namespace/tableName -> table metadata
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
    // Use raw path to preserve percent-encoded ARNs as single segments
    String rawPath = exchange.getRequestURI().getRawPath();
    // Raw path segments: ["", "buckets", "arn%3A...", "namespaces", ...]
    String[] rawSegments = rawPath.split("/");
    // Decode each segment individually
    String[] segments = new String[rawSegments.length];
    for (int i = 0; i < rawSegments.length; i++) {
      segments[i] = URLDecoder.decode(rawSegments[i], StandardCharsets.UTF_8);
    }

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
    // /buckets/{arn}/namespaces[/{namespace}]
    if (len >= 4 && "namespaces".equals(segments[3])) {
      if (len >= 5) return "DELETE".equals(method) ? "DeleteNamespace" : "GetNamespace";
      return "POST".equals(method) || "PUT".equals(method) ? "CreateNamespace" : "ListNamespaces";
    }
    // /buckets/{arn}/tables[/{namespace}/{table}[/...]]
    if (len >= 4 && "tables".equals(segments[3])) {
      if (len >= 6) return "DELETE".equals(method) ? "DeleteTable" : "GetTable";
      return "POST".equals(method) || "PUT".equals(method) ? "CreateTable" : "ListTables";
    }
    // /buckets/{arn}/policy or /buckets/{arn}/maintenance or /buckets/{arn}/compaction
    if (len >= 4 && "policy".equals(segments[3])) {
      if ("DELETE".equals(method)) return "DeleteTablePolicy";
      if ("PUT".equals(method)) return "PutTablePolicy";
      return "GetTablePolicy";
    }
    if (len >= 4 && "maintenance".equals(segments[3])) {
      return "PUT".equals(method)
          ? "PutTableMaintenanceConfiguration"
          : "GetTableMaintenanceConfiguration";
    }
    if (len >= 4 && "compaction".equals(segments[3])) {
      return "CreateTableCompaction";
    }
    // /buckets/{arn}/snapshots
    if (len >= 4 && "snapshots".equals(segments[3])) {
      return "ListTableSnapshots";
    }
    // /buckets/{arn}
    if (len == 3 && !"buckets".equals(segments[2]) && !segments[2].isEmpty()) {
      if ("DELETE".equals(method)) return "DeleteTableBucket";
      return "GetTableBucket";
    }
    // /buckets
    return ("POST".equals(method) || "PUT".equals(method))
        ? "CreateTableBucket"
        : "ListTableBuckets";
  }

  @SuppressWarnings("unchecked")
  private void route(String method, String[] segments, byte[] bodyBytes, HttpExchange exchange)
      throws IOException {
    int len = segments.length;
    // segments: ["", "buckets", {arnOrEmpty}, ...]
    String bucketArn = len >= 3 && !segments[2].isEmpty() ? segments[2] : null;

    // /buckets/{arn}/namespaces[/{namespace}]
    if (bucketArn != null && len >= 4 && "namespaces".equals(segments[3])) {
      String nsName = len >= 5 ? segments[4] : null;
      if (("POST".equals(method) || "PUT".equals(method)) && nsName == null) {
        // CreateNamespace
        Map<String, Object> body =
            bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
        Object nsObj = body.get("namespace");
        String ns = nsObj instanceof List ? (String) ((List<?>) nsObj).get(0) : (String) nsObj;
        Map<String, Map<String, Object>> bucketNs =
            namespaces.computeIfAbsent(bucketArn, k -> new ConcurrentHashMap<>());
        if (bucketNs.containsKey(ns)) {
          sendJson(
              exchange,
              409,
              Map.of("message", "Namespace already exists: " + ns, "code", "ConflictException"));
          return;
        }
        Map<String, Object> namespace = new LinkedHashMap<>();
        namespace.put("namespace", List.of(ns));
        namespace.put("tableBucketArn", bucketArn);
        namespace.put("createdAt", Instant.now().toString());
        namespace.put("ownerAccountId", ACCOUNT);
        bucketNs.put(ns, namespace);
        sendJson(exchange, 200, namespace);
        return;
      }
      if ("DELETE".equals(method) && nsName != null) {
        namespaces.getOrDefault(bucketArn, new ConcurrentHashMap<>()).remove(nsName);
        exchange.sendResponseHeaders(204, -1);
        return;
      }
      if ("GET".equals(method) && nsName == null) {
        // ListNamespaces
        List<Map<String, Object>> nsList =
            new ArrayList<>(namespaces.getOrDefault(bucketArn, new ConcurrentHashMap<>()).values());
        sendJson(exchange, 200, Map.of("namespaces", nsList));
        return;
      }
    }

    // /buckets/{arn}/tables[/{namespace}/{table}[/...]]
    if (bucketArn != null && len >= 4 && "tables".equals(segments[3])) {
      String nsName = len >= 5 ? segments[4] : null;
      String tableName = len >= 6 ? segments[5] : null;
      String subResource = len >= 7 ? segments[6] : null;

      // /buckets/{arn}/tables/{ns}/{table}/policy
      if (nsName != null && tableName != null && "policy".equals(subResource)) {
        String tableKey = nsName + "/" + tableName;
        Map<String, Object> tbl =
            tables.getOrDefault(bucketArn, new ConcurrentHashMap<>()).get(tableKey);
        if ("DELETE".equals(method)) {
          if (tbl != null) tbl.remove("policy");
          exchange.sendResponseHeaders(204, -1);
          return;
        }
        if ("PUT".equals(method)) {
          Map<String, Object> body =
              bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
          if (tbl != null) tbl.put("policy", body.get("resourcePolicy"));
          exchange.sendResponseHeaders(200, -1);
          return;
        }
        // GET
        String policy = tbl != null ? (String) tbl.get("policy") : null;
        sendJson(exchange, 200, Map.of("resourcePolicy", policy != null ? policy : "{}"));
        return;
      }

      // /buckets/{arn}/tables/{ns}/{table}/maintenance
      if (nsName != null && tableName != null && "maintenance".equals(subResource)) {
        String tableKey = nsName + "/" + tableName;
        Map<String, Object> tbl =
            tables.getOrDefault(bucketArn, new ConcurrentHashMap<>()).get(tableKey);
        if ("PUT".equals(method)) {
          if (tbl != null) {
            Map<String, Object> body =
                bodyBytes.length > 0
                    ? MAPPER.readValue(bodyBytes, Map.class)
                    : new LinkedHashMap<>();
            tbl.put("maintenanceConfiguration", body);
          }
          exchange.sendResponseHeaders(200, -1);
          return;
        }
        // GET
        Map<String, Object> config =
            tbl != null && tbl.get("maintenanceConfiguration") != null
                ? (Map<String, Object>) tbl.get("maintenanceConfiguration")
                : new LinkedHashMap<>();
        sendJson(exchange, 200, config);
        return;
      }

      // /buckets/{arn}/tables/{ns}/{table}/compaction
      if (nsName != null && tableName != null && "compaction".equals(subResource)) {
        if ("POST".equals(method) || "PUT".equals(method)) {
          sendJson(exchange, 200, Map.of("compactionJobId", UUID.randomUUID().toString()));
          return;
        }
      }

      // /buckets/{arn}/tables/{ns}/{table}/snapshots
      if (nsName != null && tableName != null && "snapshots".equals(subResource)) {
        sendJson(exchange, 200, Map.of("snapshots", List.of()));
        return;
      }

      if (("POST".equals(method) || "PUT".equals(method)) && nsName == null) {
        // CreateTable
        Map<String, Object> body =
            bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
        String ns = (String) body.get("namespace");
        String tName = (String) body.get("name");
        String tableKey = ns + "/" + tName;
        String tableArn =
            "arn:aws:s3tables:"
                + REGION
                + ":"
                + ACCOUNT
                + ":bucket/"
                + extractBucketName(bucketArn)
                + "/table/"
                + tableKey;
        Map<String, Object> table = new LinkedHashMap<>();
        table.put("name", tName);
        table.put("namespace", ns);
        table.put("type", "customer");
        table.put("tableArn", tableArn);
        table.put("createdAt", Instant.now().toString());
        table.put("modifiedAt", Instant.now().toString());
        tables.computeIfAbsent(bucketArn, k -> new ConcurrentHashMap<>()).put(tableKey, table);
        sendJson(exchange, 200, table);
        return;
      }
      if ("DELETE".equals(method) && nsName != null && tableName != null) {
        tables.getOrDefault(bucketArn, new ConcurrentHashMap<>()).remove(nsName + "/" + tableName);
        exchange.sendResponseHeaders(204, -1);
        return;
      }
      if ("GET".equals(method) && nsName != null && tableName != null) {
        // GetTable
        Map<String, Object> table =
            tables.getOrDefault(bucketArn, new ConcurrentHashMap<>()).get(nsName + "/" + tableName);
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
            new ArrayList<>(tables.getOrDefault(bucketArn, new ConcurrentHashMap<>()).values());
        sendJson(exchange, 200, Map.of("tables", tableList));
        return;
      }
    }

    // /buckets/{arn}/policy
    if (bucketArn != null && len == 4 && "policy".equals(segments[3])) {
      if ("DELETE".equals(method)) {
        Map<String, Object> bucket = tableBuckets.get(bucketArn);
        if (bucket != null) bucket.remove("policy");
        exchange.sendResponseHeaders(204, -1);
        return;
      }
      if ("PUT".equals(method)) {
        exchange.sendResponseHeaders(200, -1);
        return;
      }
      // GET
      sendJson(exchange, 200, Map.of("resourcePolicy", "{}"));
      return;
    }

    // /buckets/{arn}
    if (bucketArn != null && len == 3) {
      if ("DELETE".equals(method)) {
        tableBuckets.remove(bucketArn);
        exchange.sendResponseHeaders(204, -1);
        return;
      }
      if ("GET".equals(method)) {
        Map<String, Object> bucket = tableBuckets.get(bucketArn);
        if (bucket == null) {
          sendJson(exchange, 404, Map.of("message", "TableBucket not found: " + bucketArn));
          return;
        }
        sendJson(exchange, 200, bucket);
        return;
      }
    }

    // /buckets
    if (len <= 2) {
      if ("POST".equals(method) || "PUT".equals(method)) {
        // CreateTableBucket from body
        Map<String, Object> body =
            bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
        String bName = (String) body.get("name");
        String bArn = "arn:aws:s3tables:" + REGION + ":" + ACCOUNT + ":bucket/" + bName;
        if (tableBuckets.containsKey(bArn)) {
          sendJson(
              exchange,
              409,
              Map.of(
                  "message", "Table bucket already exists: " + bName, "code", "ConflictException"));
          return;
        }
        Map<String, Object> bucket = new LinkedHashMap<>();
        bucket.put("arn", bArn);
        bucket.put("name", bName);
        bucket.put("tableBucketId", UUID.randomUUID().toString());
        bucket.put("type", "customer");
        bucket.put("createdAt", Instant.now().toString());
        bucket.put("ownerAccountId", ACCOUNT);
        tableBuckets.put(bArn, bucket);
        sendJson(exchange, 200, bucket);
        return;
      }
      if ("GET".equals(method)) {
        // ListTableBuckets
        List<Map<String, Object>> bucketList = new ArrayList<>(tableBuckets.values());
        sendJson(exchange, 200, Map.of("tableBuckets", bucketList));
        return;
      }
    }

    sendJson(
        exchange,
        400,
        Map.of("message", "Unknown operation for " + method + " " + String.join("/", segments)));
  }

  private String extractBucketName(String arn) {
    // arn:aws:s3tables:region:account:bucket/name
    int idx = arn.lastIndexOf('/');
    return idx >= 0 ? arn.substring(idx + 1) : arn;
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
