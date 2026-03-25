package io.localwebservices.lws.providers.docdb;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

/** DocDB wire-protocol HTTP handler (AWS Query / XML protocol). */
public class DocDbHandler implements HttpHandler {

  private static final String XMLNS = "http://rds.amazonaws.com/doc/2014-10-31/";
  private static final String REQUEST_ID = "00000000-0000-0000-0000-000000000000";

  private final ServerState state;
  private final DocDbStore store;

  public DocDbHandler(ServerState state) {
    this.state = state;
    this.store = new DocDbStore();
    state.resetCallbacks.add(store::reset);
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
      if (IamMiddleware.applyIamAuth(state, "docdb", action, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "docdb", action, exchange, false)) return;

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
          Map<String, Object> cluster = store.createCluster(params);
          // Act + Assert
          sendXml(exchange, 200, buildClusterResponse("CreateDBCluster", "DBCluster", cluster));
          break;
        }
      case "DeleteDBCluster":
        {
          // Arrange
          String id = params.get("DBClusterIdentifier");
          Map<String, Object> cluster = store.deleteCluster(id);
          // Assert
          if (cluster == null) {
            sendError(exchange, 400, "DBClusterNotFoundFault", "DBCluster not found: " + id);
            return;
          }
          sendXml(exchange, 200, buildClusterResponse("DeleteDBCluster", "DBCluster", cluster));
          break;
        }
      case "DescribeDBClusters":
        {
          // Arrange
          String id = params.get("DBClusterIdentifier");
          List<Map<String, Object>> list = store.describeClusters(id);
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
          Map<String, Object> inst = store.createInstance(params);
          // Act + Assert
          sendXml(exchange, 200, buildItemResponse("CreateDBInstance", "DBInstance", inst));
          break;
        }
      case "DeleteDBInstance":
        {
          // Arrange
          String id = params.get("DBInstanceIdentifier");
          Map<String, Object> inst = store.deleteInstance(id);
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
          List<Map<String, Object>> list = store.describeInstances(id);
          // Act + Assert
          sendXml(
              exchange,
              200,
              buildListResponse("DescribeDBInstances", "DBInstances", "DBInstance", list));
          break;
        }
      case "CreateDBClusterSnapshot":
        {
          // Arrange
          Map<String, Object> snap = store.createSnapshot(params);
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
          Map<String, Object> snap = store.deleteSnapshot(snapshotId);
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
          List<Map<String, Object>> list = store.describeSnapshots(snapshotId);
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

  private String buildClusterResponse(String action, String itemTag, Map<String, Object> item) {
    return buildItemResponse(action, itemTag, item);
  }

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
