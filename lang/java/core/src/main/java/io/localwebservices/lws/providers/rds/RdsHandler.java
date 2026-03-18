package io.localwebservices.lws.providers.rds;

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
import java.util.concurrent.ConcurrentHashMap;

/** RDS wire-protocol HTTP handler (AWS Query protocol). */
public class RdsHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final ServerState state;
  private final Map<String, Map<String, Object>> instances = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> snapshots = new ConcurrentHashMap<>();

  public RdsHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(this::reset);
  }

  private void reset() {
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
        params.put(URLDecoder.decode(kv[0], "UTF-8"), URLDecoder.decode(kv[1], "UTF-8"));
      }
    }
    String action = params.getOrDefault("Action", "");

    try {
      if (IamMiddleware.applyIamAuth(state, "rds", action, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "rds", action, exchange, false)) return;

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
              "DBInstanceNotFound",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  private void handleAction(String action, Map<String, String> params, HttpExchange exchange)
      throws IOException {
    switch (action) {
      case "CreateDBInstance":
        {
          String id = params.get("DBInstanceIdentifier");
          Map<String, Object> inst = new LinkedHashMap<>();
          inst.put("DBInstanceIdentifier", id);
          inst.put("DBInstanceClass", params.getOrDefault("DBInstanceClass", "db.t3.micro"));
          inst.put("Engine", params.getOrDefault("Engine", "mysql"));
          inst.put("DBInstanceStatus", "available");
          inst.put("DBName", params.getOrDefault("DBName", ""));
          inst.put("MasterUsername", params.getOrDefault("MasterUsername", "admin"));
          inst.put(
              "AllocatedStorage", Integer.parseInt(params.getOrDefault("AllocatedStorage", "20")));
          inst.put("MultiAZ", "true".equalsIgnoreCase(params.getOrDefault("MultiAZ", "false")));
          inst.put("AvailabilityZone", params.getOrDefault("AvailabilityZone", "us-east-1a"));
          inst.put("Endpoint", Map.of("Address", "localhost", "Port", 3306));
          instances.put(id, inst);
          sendJson(exchange, 200, Map.of("CreateDBInstanceResult", Map.of("DBInstance", inst)));
          break;
        }
      case "DeleteDBInstance":
        {
          String id = params.get("DBInstanceIdentifier");
          Map<String, Object> inst = instances.remove(id);
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
          List<Map<String, Object>> list = new ArrayList<>();
          if (id != null) {
            Map<String, Object> inst = instances.get(id);
            if (inst != null) list.add(inst);
          } else {
            list.addAll(instances.values());
          }
          sendJson(exchange, 200, Map.of("DescribeDBInstancesResult", Map.of("DBInstances", list)));
          break;
        }
      case "ModifyDBInstance":
        {
          String id = params.get("DBInstanceIdentifier");
          Map<String, Object> inst = instances.get(id);
          if (inst == null) {
            sendJson(
                exchange,
                400,
                Map.of("__type", "DBInstanceNotFound", "message", "DBInstance not found: " + id));
            return;
          }
          if (params.containsKey("DBInstanceClass"))
            inst.put("DBInstanceClass", params.get("DBInstanceClass"));
          if (params.containsKey("AllocatedStorage"))
            inst.put("AllocatedStorage", Integer.parseInt(params.get("AllocatedStorage")));
          sendJson(exchange, 200, Map.of("ModifyDBInstanceResult", Map.of("DBInstance", inst)));
          break;
        }
      case "RebootDBInstance":
        {
          String id = params.get("DBInstanceIdentifier");
          Map<String, Object> inst = instances.get(id);
          if (inst == null) {
            sendJson(
                exchange,
                400,
                Map.of("__type", "DBInstanceNotFound", "message", "DBInstance not found: " + id));
            return;
          }
          sendJson(exchange, 200, Map.of("RebootDBInstanceResult", Map.of("DBInstance", inst)));
          break;
        }
      case "CreateDBSnapshot":
        {
          String snapshotId = params.get("DBSnapshotIdentifier");
          String instanceId = params.get("DBInstanceIdentifier");
          Map<String, Object> snap = new LinkedHashMap<>();
          snap.put("DBSnapshotIdentifier", snapshotId);
          snap.put("DBInstanceIdentifier", instanceId);
          snap.put("Status", "available");
          snap.put("Engine", "mysql");
          snap.put("AllocatedStorage", 20);
          snapshots.put(snapshotId, snap);
          sendJson(exchange, 200, Map.of("CreateDBSnapshotResult", Map.of("DBSnapshot", snap)));
          break;
        }
      case "DeleteDBSnapshot":
        {
          String snapshotId = params.get("DBSnapshotIdentifier");
          Map<String, Object> snap = snapshots.remove(snapshotId);
          if (snap == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "DBSnapshotNotFound",
                    "message",
                    "DBSnapshot not found: " + snapshotId));
            return;
          }
          sendJson(exchange, 200, Map.of("DeleteDBSnapshotResult", Map.of("DBSnapshot", snap)));
          break;
        }
      case "DescribeDBSnapshots":
        {
          String snapshotId = params.get("DBSnapshotIdentifier");
          List<Map<String, Object>> list = new ArrayList<>();
          if (snapshotId != null) {
            Map<String, Object> snap = snapshots.get(snapshotId);
            if (snap != null) list.add(snap);
          } else {
            list.addAll(snapshots.values());
          }
          sendJson(exchange, 200, Map.of("DescribeDBSnapshotsResult", Map.of("DBSnapshots", list)));
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
