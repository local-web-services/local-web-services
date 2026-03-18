package io.localwebservices.lws.providers.docdb;

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

/** DocDB wire-protocol HTTP handler (AWS Query protocol). */
public class DocDbHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();

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
        params.put(URLDecoder.decode(kv[0], "UTF-8"), URLDecoder.decode(kv[1], "UTF-8"));
      }
    }
    String action = params.getOrDefault("Action", "");

    try {
      if (IamMiddleware.applyIamAuth(state, "docdb", action, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "docdb", action, exchange, false)) return;

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
              "DBClusterNotFoundFault",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  private void handleAction(String action, Map<String, String> params, HttpExchange exchange)
      throws IOException {
    switch (action) {
      case "CreateDBCluster":
        {
          Map<String, Object> cluster = store.createCluster(params);
          sendJson(exchange, 200, Map.of("CreateDBClusterResult", Map.of("DBCluster", cluster)));
          break;
        }
      case "DeleteDBCluster":
        {
          String id = params.get("DBClusterIdentifier");
          Map<String, Object> cluster = store.deleteCluster(id);
          if (cluster == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "DBClusterNotFoundFault", "message", "DBCluster not found: " + id));
            return;
          }
          sendJson(exchange, 200, Map.of("DeleteDBClusterResult", Map.of("DBCluster", cluster)));
          break;
        }
      case "DescribeDBClusters":
        {
          String id = params.get("DBClusterIdentifier");
          List<Map<String, Object>> list = store.describeClusters(id);
          sendJson(exchange, 200, Map.of("DescribeDBClustersResult", Map.of("DBClusters", list)));
          break;
        }
      case "CreateDBInstance":
        {
          Map<String, Object> inst = store.createInstance(params);
          sendJson(exchange, 200, Map.of("CreateDBInstanceResult", Map.of("DBInstance", inst)));
          break;
        }
      case "DeleteDBInstance":
        {
          String id = params.get("DBInstanceIdentifier");
          Map<String, Object> inst = store.deleteInstance(id);
          if (inst == null) {
            sendJson(
                exchange,
                400,
                Map.of("__type", "DBInstanceNotFound", "message", "DBInstance not found: " + id));
            return;
          }
          sendJson(exchange, 200, Map.of("DeleteDBInstanceResult", Map.of("DBInstance", inst)));
          break;
        }
      case "DescribeDBInstances":
        {
          String id = params.get("DBInstanceIdentifier");
          List<Map<String, Object>> list = store.describeInstances(id);
          sendJson(exchange, 200, Map.of("DescribeDBInstancesResult", Map.of("DBInstances", list)));
          break;
        }
      case "CreateDBClusterSnapshot":
        {
          Map<String, Object> snap = store.createSnapshot(params);
          sendJson(
              exchange,
              200,
              Map.of("CreateDBClusterSnapshotResult", Map.of("DBClusterSnapshot", snap)));
          break;
        }
      case "DeleteDBClusterSnapshot":
        {
          String snapshotId = params.get("DBClusterSnapshotIdentifier");
          Map<String, Object> snap = store.deleteSnapshot(snapshotId);
          if (snap == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "DBClusterSnapshotNotFoundFault",
                    "message",
                    "Snapshot not found: " + snapshotId));
            return;
          }
          sendJson(
              exchange,
              200,
              Map.of("DeleteDBClusterSnapshotResult", Map.of("DBClusterSnapshot", snap)));
          break;
        }
      case "DescribeDBClusterSnapshots":
        {
          String snapshotId = params.get("DBClusterSnapshotIdentifier");
          List<Map<String, Object>> list = store.describeSnapshots(snapshotId);
          sendJson(
              exchange,
              200,
              Map.of("DescribeDBClusterSnapshotsResult", Map.of("DBClusterSnapshots", list)));
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
