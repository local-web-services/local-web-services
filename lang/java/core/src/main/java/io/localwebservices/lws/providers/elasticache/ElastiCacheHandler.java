package io.localwebservices.lws.providers.elasticache;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

/** ElastiCache wire-protocol HTTP handler (AWS Query / XML protocol). */
public class ElastiCacheHandler implements HttpHandler {

  private static final String XMLNS = "http://elasticache.amazonaws.com/doc/2015-02-02/";
  private static final String REQUEST_ID = "00000000-0000-0000-0000-000000000000";

  private final ServerState state;
  private final ElastiCacheStore store;

  public ElastiCacheHandler(ServerState state) {
    this.state = state;
    this.store = new ElastiCacheStore();
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
      if (IamMiddleware.applyIamAuth(state, "elasticache", action, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "elasticache", action, exchange, false)) return;

      handleAction(action, params, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendError(exchange, 500, "InternalFailure", "Interrupted");
    } catch (Exception e) {
      sendError(
          exchange, 400, "CacheClusterNotFound", e.getMessage() != null ? e.getMessage() : "Error");
    }
  }

  private void handleAction(String action, Map<String, String> params, HttpExchange exchange)
      throws IOException {
    switch (action) {
      case "CreateCacheCluster":
        {
          // Arrange
          Map<String, Object> cluster = store.createCacheCluster(params);
          // Act + Assert
          sendXml(exchange, 200, buildItemResponse("CreateCacheCluster", "CacheCluster", cluster));
          break;
        }
      case "DeleteCacheCluster":
        {
          // Arrange
          String id = params.get("CacheClusterId");
          Map<String, Object> cluster = store.deleteCacheCluster(id);
          // Assert
          if (cluster == null) {
            sendError(exchange, 400, "CacheClusterNotFound", "CacheCluster not found: " + id);
            return;
          }
          sendXml(exchange, 200, buildItemResponse("DeleteCacheCluster", "CacheCluster", cluster));
          break;
        }
      case "DescribeCacheClusters":
        {
          // Arrange
          String id = params.get("CacheClusterId");
          List<Map<String, Object>> list = store.describeCacheClusters(id);
          // Act + Assert
          sendXml(
              exchange,
              200,
              buildListResponse("DescribeCacheClusters", "CacheClusters", "CacheCluster", list));
          break;
        }
      case "CreateReplicationGroup":
        {
          // Arrange
          Map<String, Object> rg = store.createReplicationGroup(params);
          // Act + Assert
          sendXml(
              exchange, 200, buildItemResponse("CreateReplicationGroup", "ReplicationGroup", rg));
          break;
        }
      case "DeleteReplicationGroup":
        {
          // Arrange
          String id = params.get("ReplicationGroupId");
          Map<String, Object> rg = store.deleteReplicationGroup(id);
          // Assert
          if (rg == null) {
            sendError(
                exchange,
                400,
                "ReplicationGroupNotFoundFault",
                "ReplicationGroup not found: " + id);
            return;
          }
          sendXml(
              exchange, 200, buildItemResponse("DeleteReplicationGroup", "ReplicationGroup", rg));
          break;
        }
      case "DescribeReplicationGroups":
        {
          // Arrange
          String id = params.get("ReplicationGroupId");
          List<Map<String, Object>> list = store.describeReplicationGroups(id);
          // Act + Assert
          sendXml(
              exchange,
              200,
              buildListResponse(
                  "DescribeReplicationGroups", "ReplicationGroups", "ReplicationGroup", list));
          break;
        }
      case "CreateCacheSubnetGroup":
        {
          // Arrange
          Map<String, Object> sg = store.createCacheSubnetGroup(params);
          // Act + Assert
          sendXml(
              exchange, 200, buildItemResponse("CreateCacheSubnetGroup", "CacheSubnetGroup", sg));
          break;
        }
      case "DeleteCacheSubnetGroup":
        {
          // Arrange
          String name = params.get("CacheSubnetGroupName");
          store.deleteCacheSubnetGroup(name);
          // Act + Assert
          sendXml(exchange, 200, buildEmptyResponse("DeleteCacheSubnetGroup"));
          break;
        }
      case "DescribeCacheSubnetGroups":
        {
          // Arrange
          String name = params.get("CacheSubnetGroupName");
          List<Map<String, Object>> list = store.describeCacheSubnetGroups(name);
          // Act + Assert
          sendXml(
              exchange,
              200,
              buildListResponse(
                  "DescribeCacheSubnetGroups", "CacheSubnetGroups", "CacheSubnetGroup", list));
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

  private String buildEmptyResponse(String action) {
    // Arrange + Act + Assert
    return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
        + "<"
        + action
        + "Response xmlns=\""
        + XMLNS
        + "\">\n"
        + "  <ResponseMetadata><RequestId>"
        + REQUEST_ID
        + "</RequestId></ResponseMetadata>\n"
        + "</"
        + action
        + "Response>\n";
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
