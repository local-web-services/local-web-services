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
import java.util.concurrent.ConcurrentHashMap;

/** ElastiCache wire-protocol HTTP handler (AWS Query protocol). */
public class ElastiCacheHandler implements HttpHandler {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    private final ServerState state;
    private final Map<String, Map<String, Object>> cacheClusters = new ConcurrentHashMap<>();
    private final Map<String, Map<String, Object>> replicationGroups = new ConcurrentHashMap<>();
    private final Map<String, Map<String, Object>> subnetGroups = new ConcurrentHashMap<>();

    public ElastiCacheHandler(ServerState state) {
        this.state = state;
        state.resetCallbacks.add(this::reset);
    }

    private void reset() {
        cacheClusters.clear();
        replicationGroups.clear();
        subnetGroups.clear();
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
            if (IamMiddleware.applyIamAuth(state, "elasticache", action, exchange, false)) return;
            if (ChaosMiddleware.applyChaos(state, "elasticache", action, exchange, false)) return;

            handleAction(action, params, exchange);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
        } catch (Exception e) {
            sendJson(exchange, 400, Map.of("__type", "CacheClusterNotFound", "message", e.getMessage() != null ? e.getMessage() : "Error"));
        }
    }

    private void handleAction(String action, Map<String, String> params, HttpExchange exchange) throws IOException {
        switch (action) {
            case "CreateCacheCluster": {
                String id = params.get("CacheClusterId");
                Map<String, Object> cluster = new LinkedHashMap<>();
                cluster.put("CacheClusterId", id);
                cluster.put("CacheClusterStatus", "available");
                cluster.put("Engine", params.getOrDefault("Engine", "redis"));
                cluster.put("EngineVersion", params.getOrDefault("EngineVersion", "7.0.7"));
                cluster.put("NumCacheNodes", Integer.parseInt(params.getOrDefault("NumCacheNodes", "1")));
                cluster.put("CacheNodeType", params.getOrDefault("CacheNodeType", "cache.t3.micro"));
                Map<String, Object> node = new LinkedHashMap<>();
                node.put("CacheNodeId", "0001");
                node.put("CacheNodeStatus", "available");
                node.put("Endpoint", Map.of("Address", "localhost", "Port", 6379));
                cluster.put("CacheNodes", List.of(node));
                cacheClusters.put(id, cluster);
                sendJson(exchange, 200, Map.of("CreateCacheClusterResult", Map.of("CacheCluster", cluster)));
                break;
            }
            case "DeleteCacheCluster": {
                String id = params.get("CacheClusterId");
                Map<String, Object> cluster = cacheClusters.remove(id);
                if (cluster == null) {
                    sendJson(exchange, 400, Map.of("__type", "CacheClusterNotFound", "message", "CacheCluster not found: " + id));
                    return;
                }
                sendJson(exchange, 200, Map.of("DeleteCacheClusterResult", Map.of("CacheCluster", cluster)));
                break;
            }
            case "DescribeCacheClusters": {
                String id = params.get("CacheClusterId");
                List<Map<String, Object>> list = new ArrayList<>();
                if (id != null) {
                    Map<String, Object> cluster = cacheClusters.get(id);
                    if (cluster != null) list.add(cluster);
                } else {
                    list.addAll(cacheClusters.values());
                }
                sendJson(exchange, 200, Map.of("DescribeCacheClustersResult", Map.of("CacheClusters", list)));
                break;
            }
            case "CreateReplicationGroup": {
                String id = params.get("ReplicationGroupId");
                Map<String, Object> rg = new LinkedHashMap<>();
                rg.put("ReplicationGroupId", id);
                rg.put("Status", "available");
                rg.put("Description", params.getOrDefault("ReplicationGroupDescription", ""));
                rg.put("MemberClusters", List.of(id + "-001"));
                Map<String, Object> nodeGroup = new LinkedHashMap<>();
                nodeGroup.put("NodeGroupId", "0001");
                nodeGroup.put("Status", "available");
                nodeGroup.put("PrimaryEndpoint", Map.of("Address", "localhost", "Port", 6379));
                rg.put("NodeGroups", List.of(nodeGroup));
                replicationGroups.put(id, rg);
                sendJson(exchange, 200, Map.of("CreateReplicationGroupResult", Map.of("ReplicationGroup", rg)));
                break;
            }
            case "DeleteReplicationGroup": {
                String id = params.get("ReplicationGroupId");
                Map<String, Object> rg = replicationGroups.remove(id);
                if (rg == null) {
                    sendJson(exchange, 400, Map.of("__type", "ReplicationGroupNotFoundFault", "message", "ReplicationGroup not found: " + id));
                    return;
                }
                sendJson(exchange, 200, Map.of("DeleteReplicationGroupResult", Map.of("ReplicationGroup", rg)));
                break;
            }
            case "DescribeReplicationGroups": {
                String id = params.get("ReplicationGroupId");
                List<Map<String, Object>> list = new ArrayList<>();
                if (id != null) {
                    Map<String, Object> rg = replicationGroups.get(id);
                    if (rg != null) list.add(rg);
                } else {
                    list.addAll(replicationGroups.values());
                }
                sendJson(exchange, 200, Map.of("DescribeReplicationGroupsResult", Map.of("ReplicationGroups", list)));
                break;
            }
            case "CreateCacheSubnetGroup": {
                String name = params.get("CacheSubnetGroupName");
                Map<String, Object> sg = new LinkedHashMap<>();
                sg.put("CacheSubnetGroupName", name);
                sg.put("CacheSubnetGroupDescription", params.getOrDefault("CacheSubnetGroupDescription", ""));
                sg.put("VpcId", "vpc-00000000");
                sg.put("Subnets", List.of());
                subnetGroups.put(name, sg);
                sendJson(exchange, 200, Map.of("CreateCacheSubnetGroupResult", Map.of("CacheSubnetGroup", sg)));
                break;
            }
            case "DeleteCacheSubnetGroup": {
                String name = params.get("CacheSubnetGroupName");
                subnetGroups.remove(name);
                sendJson(exchange, 200, Map.of());
                break;
            }
            case "DescribeCacheSubnetGroups": {
                String name = params.get("CacheSubnetGroupName");
                List<Map<String, Object>> list = new ArrayList<>();
                if (name != null) {
                    Map<String, Object> sg = subnetGroups.get(name);
                    if (sg != null) list.add(sg);
                } else {
                    list.addAll(subnetGroups.values());
                }
                sendJson(exchange, 200, Map.of("DescribeCacheSubnetGroupsResult", Map.of("CacheSubnetGroups", list)));
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
