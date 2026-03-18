package io.localwebservices.lws.providers.elasticache;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

/** ElastiCache wire-protocol HTTP handler (AWS Query protocol). */
public class ElastiCacheHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();

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
        params.put(URLDecoder.decode(kv[0], "UTF-8"), URLDecoder.decode(kv[1], "UTF-8"));
      }
    }
    String action = params.getOrDefault("Action", "");

    try {
      if (IamMiddleware.applyIamAuth(state, "elasticache", action, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "elasticache", action, exchange, false)) return;

      handleAction(action, params, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      sendJson(
          exchange,
          400,
          Map.of(
              "__type",
              "CacheClusterNotFound",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  private void handleAction(String action, Map<String, String> params, HttpExchange exchange)
      throws IOException {
    switch (action) {
      case "CreateCacheCluster":
        {
          Map<String, Object> cluster = store.createCacheCluster(params);
          sendJson(
              exchange, 200, Map.of("CreateCacheClusterResult", Map.of("CacheCluster", cluster)));
          break;
        }
      case "DeleteCacheCluster":
        {
          String id = params.get("CacheClusterId");
          Map<String, Object> cluster = store.deleteCacheCluster(id);
          if (cluster == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "CacheClusterNotFound", "message", "CacheCluster not found: " + id));
            return;
          }
          sendJson(
              exchange, 200, Map.of("DeleteCacheClusterResult", Map.of("CacheCluster", cluster)));
          break;
        }
      case "DescribeCacheClusters":
        {
          String id = params.get("CacheClusterId");
          List<Map<String, Object>> list = store.describeCacheClusters(id);
          sendJson(
              exchange, 200, Map.of("DescribeCacheClustersResult", Map.of("CacheClusters", list)));
          break;
        }
      case "CreateReplicationGroup":
        {
          Map<String, Object> rg = store.createReplicationGroup(params);
          sendJson(
              exchange,
              200,
              Map.of("CreateReplicationGroupResult", Map.of("ReplicationGroup", rg)));
          break;
        }
      case "DeleteReplicationGroup":
        {
          String id = params.get("ReplicationGroupId");
          Map<String, Object> rg = store.deleteReplicationGroup(id);
          if (rg == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ReplicationGroupNotFoundFault",
                    "message",
                    "ReplicationGroup not found: " + id));
            return;
          }
          sendJson(
              exchange,
              200,
              Map.of("DeleteReplicationGroupResult", Map.of("ReplicationGroup", rg)));
          break;
        }
      case "DescribeReplicationGroups":
        {
          String id = params.get("ReplicationGroupId");
          List<Map<String, Object>> list = store.describeReplicationGroups(id);
          sendJson(
              exchange,
              200,
              Map.of("DescribeReplicationGroupsResult", Map.of("ReplicationGroups", list)));
          break;
        }
      case "CreateCacheSubnetGroup":
        {
          Map<String, Object> sg = store.createCacheSubnetGroup(params);
          sendJson(
              exchange,
              200,
              Map.of("CreateCacheSubnetGroupResult", Map.of("CacheSubnetGroup", sg)));
          break;
        }
      case "DeleteCacheSubnetGroup":
        {
          String name = params.get("CacheSubnetGroupName");
          store.deleteCacheSubnetGroup(name);
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "DescribeCacheSubnetGroups":
        {
          String name = params.get("CacheSubnetGroupName");
          List<Map<String, Object>> list = store.describeCacheSubnetGroups(name);
          sendJson(
              exchange,
              200,
              Map.of("DescribeCacheSubnetGroupsResult", Map.of("CacheSubnetGroups", list)));
          break;
        }
      default:
        {
          sendJson(
              exchange,
              400,
              Map.of(
                  "__type", "UnknownOperationException", "message", "Not implemented: " + action));
        }
    }
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
