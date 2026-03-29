package io.localwebservices.lws.providers.neptune;

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

/** Neptune wire-protocol HTTP handler (AWS Query / XML protocol). */
public class NeptuneHandler implements HttpHandler {

  private static final String XMLNS = "http://rds.amazonaws.com/doc/2014-10-31/";
  private static final String REQUEST_ID = "00000000-0000-0000-0000-000000000000";

  private final ServerState state;
  private final Map<String, Map<String, Object>> clusters = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> instances = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> snapshots = new ConcurrentHashMap<>();

  public NeptuneHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(this::reset);
  }

  private void reset() {
    clusters.clear();
    instances.clear();
    snapshots.clear();
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }

    String bodyStr = new String(bodyBytes, StandardCharsets.UTF_8);
    Map<String, String> params = new LinkedHashMap<>();
    for (String pair : bodyStr.split("&")) {
      String[] kv = pair.split("=", 2);
      if (kv.length == 2) {
        params.put(
            URLDecoder.decode(kv[0], StandardCharsets.UTF_8),
            URLDecoder.decode(kv[1], StandardCharsets.UTF_8));
      }
    }
    String action = params.getOrDefault("Action", "");

    try {
      if (IamMiddleware.applyIamAuth(state, "neptune", action, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "neptune", action, exchange, false)) return;

      handleAction(action, params, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendError(exchange, 500, "InternalFailure", "Interrupted");
    } catch (Exception e) {
      sendError(
          exchange,
          400,
          "DBClusterNotFoundFault",
          e.getMessage() != null ? e.getMessage() : "Error");
    }
  }

  private void handleAction(String action, Map<String, String> params, HttpExchange exchange)
      throws IOException {
    switch (action) {
      case "CreateDBCluster":
        {
          // Arrange
          String id = params.get("DBClusterIdentifier");
          Map<String, Object> cluster = new LinkedHashMap<>();
          cluster.put("DBClusterIdentifier", id);
          cluster.put("Status", "available");
          cluster.put("Engine", "neptune");
          cluster.put("Endpoint", "localhost");
          cluster.put("ReaderEndpoint", "localhost");
          cluster.put("Port", "8182");
          cluster.put("MasterUsername", params.getOrDefault("MasterUsername", "admin"));
          clusters.put(id, cluster);
          // Act + Assert
          sendXml(exchange, 200, buildItemResponse("CreateDBCluster", "DBCluster", cluster));
          break;
        }
      case "DeleteDBCluster":
        {
          // Arrange
          String id = params.get("DBClusterIdentifier");
          Map<String, Object> cluster = clusters.remove(id);
          // Assert
          if (cluster == null) {
            sendError(exchange, 400, "DBClusterNotFoundFault", "DBCluster not found: " + id);
            return;
          }
          sendXml(exchange, 200, buildItemResponse("DeleteDBCluster", "DBCluster", cluster));
          break;
        }
      case "DescribeDBClusters":
        {
          // Arrange
          String id = params.get("DBClusterIdentifier");
          List<Map<String, Object>> list = new ArrayList<>();
          if (id != null) {
            Map<String, Object> cluster = clusters.get(id);
            if (cluster != null) list.add(cluster);
          } else {
            list.addAll(clusters.values());
          }
          // Act + Assert
          sendXml(
              exchange,
              200,
              buildListResponse("DescribeDBClusters", "DBClusters", "DBCluster", list));
          break;
        }
      case "CreateDBInstance":
        {
          // Arrange
          String id = params.get("DBInstanceIdentifier");
          Map<String, Object> inst = new LinkedHashMap<>();
          inst.put("DBInstanceIdentifier", id);
          inst.put("DBClusterIdentifier", params.getOrDefault("DBClusterIdentifier", ""));
          inst.put("DBInstanceClass", params.getOrDefault("DBInstanceClass", "db.r5.large"));
          inst.put("Engine", "neptune");
          inst.put("DBInstanceStatus", "available");
          inst.put("Endpoint", Map.of("Address", "localhost", "Port", "8182"));
          instances.put(id, inst);
          // Act + Assert
          sendXml(exchange, 200, buildItemResponse("CreateDBInstance", "DBInstance", inst));
          break;
        }
      case "DeleteDBInstance":
        {
          // Arrange
          String id = params.get("DBInstanceIdentifier");
          Map<String, Object> inst = instances.remove(id);
          // Assert
          if (inst == null) {
            sendError(exchange, 400, "DBInstanceNotFound", "DBInstance not found: " + id);
            return;
          }
          sendXml(exchange, 200, buildItemResponse("DeleteDBInstance", "DBInstance", inst));
          break;
        }
      case "DescribeDBInstances":
        {
          // Arrange
          String id = params.get("DBInstanceIdentifier");
          List<Map<String, Object>> list = new ArrayList<>();
          if (id != null) {
            Map<String, Object> inst = instances.get(id);
            if (inst != null) list.add(inst);
          } else {
            list.addAll(instances.values());
          }
          // Act + Assert
          sendXml(
              exchange,
              200,
              buildListResponse("DescribeDBInstances", "DBInstances", "DBInstance", list));
          break;
        }
      case "RebootDBInstance":
        {
          // Arrange
          String id = params.get("DBInstanceIdentifier");
          Map<String, Object> inst = instances.get(id);
          // Assert
          if (inst == null) {
            sendError(exchange, 400, "DBInstanceNotFound", "DBInstance not found: " + id);
            return;
          }
          sendXml(exchange, 200, buildItemResponse("RebootDBInstance", "DBInstance", inst));
          break;
        }
      case "StartDBCluster":
        {
          // Arrange
          String id = params.get("DBClusterIdentifier");
          Map<String, Object> cluster = clusters.get(id);
          // Assert
          if (cluster == null) {
            sendError(exchange, 400, "DBClusterNotFoundFault", "DBCluster not found: " + id);
            return;
          }
          cluster.put("Status", "available");
          sendXml(exchange, 200, buildItemResponse("StartDBCluster", "DBCluster", cluster));
          break;
        }
      case "StopDBCluster":
        {
          // Arrange
          String id = params.get("DBClusterIdentifier");
          Map<String, Object> cluster = clusters.get(id);
          // Assert
          if (cluster == null) {
            sendError(exchange, 400, "DBClusterNotFoundFault", "DBCluster not found: " + id);
            return;
          }
          cluster.put("Status", "stopped");
          sendXml(exchange, 200, buildItemResponse("StopDBCluster", "DBCluster", cluster));
          break;
        }
      case "CreateDBClusterSnapshot":
        {
          // Arrange
          String snapshotId = params.get("DBClusterSnapshotIdentifier");
          String clusterId = params.get("DBClusterIdentifier");
          Map<String, Object> snap = new LinkedHashMap<>();
          snap.put("DBClusterSnapshotIdentifier", snapshotId);
          snap.put("DBClusterIdentifier", clusterId);
          snap.put("Status", "available");
          snap.put("Engine", "neptune");
          snapshots.put(snapshotId, snap);
          // Act + Assert
          sendXml(
              exchange,
              200,
              buildItemResponse("CreateDBClusterSnapshot", "DBClusterSnapshot", snap));
          break;
        }
      case "DeleteDBClusterSnapshot":
        {
          // Arrange
          String snapshotId = params.get("DBClusterSnapshotIdentifier");
          Map<String, Object> snap = snapshots.remove(snapshotId);
          // Assert
          if (snap == null) {
            sendError(
                exchange,
                400,
                "DBClusterSnapshotNotFoundFault",
                "Snapshot not found: " + snapshotId);
            return;
          }
          sendXml(
              exchange,
              200,
              buildItemResponse("DeleteDBClusterSnapshot", "DBClusterSnapshot", snap));
          break;
        }
      case "DescribeDBClusterSnapshots":
        {
          // Arrange
          String snapshotId = params.get("DBClusterSnapshotIdentifier");
          List<Map<String, Object>> list = new ArrayList<>();
          if (snapshotId != null) {
            Map<String, Object> snap = snapshots.get(snapshotId);
            if (snap != null) list.add(snap);
          } else {
            list.addAll(snapshots.values());
          }
          // Act + Assert
          sendXml(
              exchange,
              200,
              buildListResponse(
                  "DescribeDBClusterSnapshots", "DBClusterSnapshots", "DBClusterSnapshot", list));
          break;
        }
      default:
        sendError(exchange, 400, "UnknownOperationException", "Not implemented: " + action);
    }
  }

  // ── XML response helpers ──────────────────────────────────────────────────────

  private String buildItemResponse(String action, String itemTag, Map<String, Object> item) {
    // Arrange
    StringBuilder sb = new StringBuilder();
    // Act
    sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
    sb.append("<").append(action).append("Response xmlns=\"").append(XMLNS).append("\">\n");
    sb.append("  <").append(action).append("Result>\n");
    sb.append("    <").append(itemTag).append(">\n");
    appendMapFields(sb, item, 6);
    sb.append("    </").append(itemTag).append(">\n");
    sb.append("  </").append(action).append("Result>\n");
    sb.append("  <ResponseMetadata><RequestId>")
        .append(REQUEST_ID)
        .append("</RequestId></ResponseMetadata>\n");
    sb.append("</").append(action).append("Response>\n");
    // Assert: return built XML
    return sb.toString();
  }

  private String buildListResponse(
      String action, String listTag, String itemTag, List<Map<String, Object>> items) {
    // Arrange
    StringBuilder sb = new StringBuilder();
    // Act
    sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
    sb.append("<").append(action).append("Response xmlns=\"").append(XMLNS).append("\">\n");
    sb.append("  <").append(action).append("Result>\n");
    sb.append("    <").append(listTag).append(">\n");
    for (Map<String, Object> item : items) {
      sb.append("      <").append(itemTag).append(">\n");
      appendMapFields(sb, item, 8);
      sb.append("      </").append(itemTag).append(">\n");
    }
    sb.append("    </").append(listTag).append(">\n");
    sb.append("  </").append(action).append("Result>\n");
    sb.append("  <ResponseMetadata><RequestId>")
        .append(REQUEST_ID)
        .append("</RequestId></ResponseMetadata>\n");
    sb.append("</").append(action).append("Response>\n");
    // Assert: return built XML
    return sb.toString();
  }

  @SuppressWarnings("unchecked")
  private void appendMapFields(StringBuilder sb, Map<String, Object> map, int indent) {
    // Arrange
    String pad = " ".repeat(indent);
    // Act
    for (Map.Entry<String, Object> entry : map.entrySet()) {
      String key = entry.getKey();
      Object val = entry.getValue();
      if (val instanceof Map) {
        sb.append(pad).append("<").append(key).append(">\n");
        appendMapFields(sb, (Map<String, Object>) val, indent + 2);
        sb.append(pad).append("</").append(key).append(">\n");
      } else if (val != null) {
        sb.append(pad)
            .append("<")
            .append(key)
            .append(">")
            .append(escapeXml(val.toString()))
            .append("</")
            .append(key)
            .append(">\n");
      }
    }
  }

  private String escapeXml(String s) {
    // Arrange
    if (s == null) return "";
    // Act + Assert
    return s.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace("\"", "&quot;");
  }

  private void sendXml(HttpExchange exchange, int status, String xml) throws IOException {
    // Arrange
    byte[] bytes = xml.getBytes(StandardCharsets.UTF_8);
    // Act
    exchange.getResponseHeaders().set("Content-Type", "text/xml; charset=UTF-8");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }

  private void sendError(HttpExchange exchange, int status, String code, String message)
      throws IOException {
    // Arrange
    String xml =
        "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
            + "<ErrorResponse xmlns=\""
            + XMLNS
            + "\">\n"
            + "  <Error>\n"
            + "    <Code>"
            + escapeXml(code)
            + "</Code>\n"
            + "    <Message>"
            + escapeXml(message)
            + "</Message>\n"
            + "  </Error>\n"
            + "  <RequestId>"
            + REQUEST_ID
            + "</RequestId>\n"
            + "</ErrorResponse>\n";
    // Act
    sendXml(exchange, status, xml);
  }
}
