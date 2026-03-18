package io.localwebservices.lws.providers.memorydb;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** MemoryDB wire-protocol HTTP handler (JSON, X-Amz-Target). */
public class MemoryDbHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String TARGET_PREFIX = "AmazonMemoryDB.";

  private final ServerState state;
  private final Map<String, Map<String, Object>> clusters = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> users = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> acls = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> snapshots = new ConcurrentHashMap<>();

  public MemoryDbHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(this::reset);
  }

  private void reset() {
    clusters.clear();
    users.clear();
    acls.clear();
    snapshots.clear();
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
    if (target == null) target = "";
    String operation =
        target.startsWith(TARGET_PREFIX) ? target.substring(TARGET_PREFIX.length()) : target;

    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> body =
        bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();

    try {
      if (IamMiddleware.applyIamAuth(state, "memorydb", operation, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "memorydb", operation, exchange, false)) return;

      handleOperation(operation, body, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      sendJson(
          exchange,
          400,
          Map.of(
              "__type",
              "ClusterNotFoundFault",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  @SuppressWarnings("unchecked")
  private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateCluster":
        {
          String name = (String) body.get("ClusterName");
          Map<String, Object> cluster = new LinkedHashMap<>();
          cluster.put("Name", name);
          cluster.put("Status", "available");
          cluster.put("NumberOfShards", body.getOrDefault("NumShards", 1));
          cluster.put("EngineVersion", body.getOrDefault("EngineVersion", "7.0"));
          cluster.put("ClusterEndpoint", Map.of("Address", "localhost", "Port", 6379));
          clusters.put(name, cluster);
          sendJson(exchange, 200, Map.of("Cluster", cluster));
          break;
        }
      case "DeleteCluster":
        {
          String name = (String) body.get("ClusterName");
          Map<String, Object> cluster = clusters.remove(name);
          if (cluster == null) {
            sendJson(
                exchange,
                400,
                Map.of("__type", "ClusterNotFoundFault", "message", "Cluster not found: " + name));
            return;
          }
          sendJson(exchange, 200, Map.of("Cluster", cluster));
          break;
        }
      case "DescribeClusters":
        {
          String name = (String) body.get("ClusterName");
          List<Map<String, Object>> list = new ArrayList<>();
          if (name != null) {
            Map<String, Object> cluster = clusters.get(name);
            if (cluster != null) list.add(cluster);
          } else {
            list.addAll(clusters.values());
          }
          sendJson(exchange, 200, Map.of("Clusters", list));
          break;
        }
      case "CreateUser":
        {
          String name = (String) body.get("UserName");
          Map<String, Object> user = new LinkedHashMap<>();
          user.put("Name", name);
          user.put("Status", "active");
          user.put("AccessString", body.getOrDefault("AccessString", "on ~* &* +@all"));
          users.put(name, user);
          sendJson(exchange, 200, Map.of("User", user));
          break;
        }
      case "DeleteUser":
        {
          String name = (String) body.get("UserName");
          Map<String, Object> user = users.remove(name);
          if (user == null) {
            sendJson(
                exchange,
                400,
                Map.of("__type", "UserNotFoundFault", "message", "User not found: " + name));
            return;
          }
          sendJson(exchange, 200, Map.of("User", user));
          break;
        }
      case "DescribeUsers":
        {
          String name = (String) body.get("UserName");
          List<Map<String, Object>> list = new ArrayList<>();
          if (name != null) {
            Map<String, Object> user = users.get(name);
            if (user != null) list.add(user);
          } else {
            list.addAll(users.values());
          }
          sendJson(exchange, 200, Map.of("Users", list));
          break;
        }
      case "CreateACL":
        {
          String name = (String) body.get("ACLName");
          Map<String, Object> acl = new LinkedHashMap<>();
          acl.put("Name", name);
          acl.put("Status", "active");
          acl.put("UserNames", body.getOrDefault("UserNames", List.of()));
          acls.put(name, acl);
          sendJson(exchange, 200, Map.of("ACL", acl));
          break;
        }
      case "DeleteACL":
        {
          String name = (String) body.get("ACLName");
          Map<String, Object> acl = acls.remove(name);
          if (acl == null) {
            sendJson(
                exchange,
                400,
                Map.of("__type", "ACLNotFoundFault", "message", "ACL not found: " + name));
            return;
          }
          sendJson(exchange, 200, Map.of("ACL", acl));
          break;
        }
      case "DescribeACLs":
        {
          String name = (String) body.get("ACLName");
          List<Map<String, Object>> list = new ArrayList<>();
          if (name != null) {
            Map<String, Object> acl = acls.get(name);
            if (acl != null) list.add(acl);
          } else {
            list.addAll(acls.values());
          }
          sendJson(exchange, 200, Map.of("ACLs", list));
          break;
        }
      case "CreateSnapshot":
        {
          String name = (String) body.get("SnapshotName");
          Map<String, Object> snap = new LinkedHashMap<>();
          snap.put("Name", name);
          snap.put("Status", "available");
          snap.put("ClusterName", body.getOrDefault("ClusterName", ""));
          snapshots.put(name, snap);
          sendJson(exchange, 200, Map.of("Snapshot", snap));
          break;
        }
      case "DeleteSnapshot":
        {
          String name = (String) body.get("SnapshotName");
          Map<String, Object> snap = snapshots.remove(name);
          if (snap == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "SnapshotNotFoundFault", "message", "Snapshot not found: " + name));
            return;
          }
          sendJson(exchange, 200, Map.of("Snapshot", snap));
          break;
        }
      case "DescribeSnapshots":
        {
          String name = (String) body.get("SnapshotName");
          List<Map<String, Object>> list = new ArrayList<>();
          if (name != null) {
            Map<String, Object> snap = snapshots.get(name);
            if (snap != null) list.add(snap);
          } else {
            list.addAll(snapshots.values());
          }
          sendJson(exchange, 200, Map.of("Snapshots", list));
          break;
        }
      default:
        {
          sendJson(
              exchange,
              400,
              Map.of(
                  "__type",
                  "UnknownOperationException",
                  "message",
                  "Not implemented: " + operation));
        }
    }
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
