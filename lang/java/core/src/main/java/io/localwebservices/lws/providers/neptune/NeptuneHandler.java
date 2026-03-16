package io.localwebservices.lws.providers.neptune;

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

/** Neptune wire-protocol HTTP handler (AWS Query protocol). */
public class NeptuneHandler implements HttpHandler {

    private static final ObjectMapper MAPPER = new ObjectMapper();

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
        try (InputStream is = exchange.getRequestBody()) { bodyBytes = is.readAllBytes(); }

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
            if (IamMiddleware.applyIamAuth(state, "neptune", action, exchange, false)) return;
            if (ChaosMiddleware.applyChaos(state, "neptune", action, exchange, false)) return;

            handleAction(action, params, exchange);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
        } catch (Exception e) {
            sendJson(exchange, 400, Map.of("__type", "DBClusterNotFoundFault", "message", e.getMessage() != null ? e.getMessage() : "Error"));
        }
    }

    private void handleAction(String action, Map<String, String> params, HttpExchange exchange) throws IOException {
        switch (action) {
            case "CreateDBCluster": {
                String id = params.get("DBClusterIdentifier");
                Map<String, Object> cluster = new LinkedHashMap<>();
                cluster.put("DBClusterIdentifier", id);
                cluster.put("Status", "available");
                cluster.put("Engine", "neptune");
                cluster.put("Endpoint", "localhost");
                cluster.put("ReaderEndpoint", "localhost");
                cluster.put("Port", 8182);
                cluster.put("MasterUsername", params.getOrDefault("MasterUsername", "admin"));
                clusters.put(id, cluster);
                sendJson(exchange, 200, Map.of("CreateDBClusterResult", Map.of("DBCluster", cluster)));
                break;
            }
            case "DeleteDBCluster": {
                String id = params.get("DBClusterIdentifier");
                Map<String, Object> cluster = clusters.remove(id);
                if (cluster == null) {
                    sendJson(exchange, 400, Map.of("__type", "DBClusterNotFoundFault", "message", "DBCluster not found: " + id));
                    return;
                }
                sendJson(exchange, 200, Map.of("DeleteDBClusterResult", Map.of("DBCluster", cluster)));
                break;
            }
            case "DescribeDBClusters": {
                String id = params.get("DBClusterIdentifier");
                List<Map<String, Object>> list = new ArrayList<>();
                if (id != null) {
                    Map<String, Object> cluster = clusters.get(id);
                    if (cluster != null) list.add(cluster);
                } else {
                    list.addAll(clusters.values());
                }
                sendJson(exchange, 200, Map.of("DescribeDBClustersResult", Map.of("DBClusters", list)));
                break;
            }
            case "CreateDBInstance": {
                String id = params.get("DBInstanceIdentifier");
                Map<String, Object> inst = new LinkedHashMap<>();
                inst.put("DBInstanceIdentifier", id);
                inst.put("DBClusterIdentifier", params.getOrDefault("DBClusterIdentifier", ""));
                inst.put("DBInstanceClass", params.getOrDefault("DBInstanceClass", "db.r5.large"));
                inst.put("Engine", "neptune");
                inst.put("DBInstanceStatus", "available");
                inst.put("Endpoint", Map.of("Address", "localhost", "Port", 8182));
                instances.put(id, inst);
                sendJson(exchange, 200, Map.of("CreateDBInstanceResult", Map.of("DBInstance", inst)));
                break;
            }
            case "DeleteDBInstance": {
                String id = params.get("DBInstanceIdentifier");
                Map<String, Object> inst = instances.remove(id);
                if (inst == null) {
                    sendJson(exchange, 400, Map.of("__type", "DBInstanceNotFound", "message", "DBInstance not found: " + id));
                    return;
                }
                sendJson(exchange, 200, Map.of("DeleteDBInstanceResult", Map.of("DBInstance", inst)));
                break;
            }
            case "DescribeDBInstances": {
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
            case "CreateDBClusterSnapshot": {
                String snapshotId = params.get("DBClusterSnapshotIdentifier");
                String clusterId = params.get("DBClusterIdentifier");
                Map<String, Object> snap = new LinkedHashMap<>();
                snap.put("DBClusterSnapshotIdentifier", snapshotId);
                snap.put("DBClusterIdentifier", clusterId);
                snap.put("Status", "available");
                snap.put("Engine", "neptune");
                snapshots.put(snapshotId, snap);
                sendJson(exchange, 200, Map.of("CreateDBClusterSnapshotResult", Map.of("DBClusterSnapshot", snap)));
                break;
            }
            case "DeleteDBClusterSnapshot": {
                String snapshotId = params.get("DBClusterSnapshotIdentifier");
                Map<String, Object> snap = snapshots.remove(snapshotId);
                if (snap == null) {
                    sendJson(exchange, 400, Map.of("__type", "DBClusterSnapshotNotFoundFault", "message", "Snapshot not found: " + snapshotId));
                    return;
                }
                sendJson(exchange, 200, Map.of("DeleteDBClusterSnapshotResult", Map.of("DBClusterSnapshot", snap)));
                break;
            }
            case "DescribeDBClusterSnapshots": {
                String snapshotId = params.get("DBClusterSnapshotIdentifier");
                List<Map<String, Object>> list = new ArrayList<>();
                if (snapshotId != null) {
                    Map<String, Object> snap = snapshots.get(snapshotId);
                    if (snap != null) list.add(snap);
                } else {
                    list.addAll(snapshots.values());
                }
                sendJson(exchange, 200, Map.of("DescribeDBClusterSnapshotsResult", Map.of("DBClusterSnapshots", list)));
                break;
            }
            default: {
                sendJson(exchange, 400, Map.of("__type", "UnknownOperationException", "message", "Not implemented: " + action));
            }
        }
    }

    private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
        byte[] bytes = MAPPER.writeValueAsBytes(body);
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
    }
}
