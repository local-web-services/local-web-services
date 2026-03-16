package io.localwebservices.lws.providers.apigateway;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * API Gateway REST wire-protocol HTTP handler.
 *
 * Routes use REST-style paths:
 *   POST/GET /restapis
 *   GET/DELETE /restapis/:id
 *   GET/POST/DELETE /restapis/:id/resources[/:resourceId]
 *   PUT/GET/DELETE /restapis/:id/resources/:rId/methods/:m[/integration[/responses/:s]][/responses/:s]
 *   POST/GET/DELETE /restapis/:id/deployments[/:deploymentId]
 *   POST/GET/DELETE/PATCH /restapis/:id/stages[/:stageName]
 */
public class ApiGatewayHandler implements HttpHandler {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    private final ServerState state;

    // apiId -> RestAPI
    private final Map<String, Map<String, Object>> apis = new ConcurrentHashMap<>();
    // apiId -> resourceId -> resource
    private final Map<String, Map<String, Map<String, Object>>> resources = new ConcurrentHashMap<>();
    // apiId -> deploymentId -> deployment
    private final Map<String, Map<String, Map<String, Object>>> deployments = new ConcurrentHashMap<>();
    // apiId -> stageName -> stage
    private final Map<String, Map<String, Map<String, Object>>> stages = new ConcurrentHashMap<>();

    public ApiGatewayHandler(ServerState state) {
        this.state = state;
        state.resetCallbacks.add(this::reset);
    }

    private void reset() {
        apis.clear();
        resources.clear();
        deployments.clear();
        stages.clear();
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        String method = exchange.getRequestMethod();
        String path = exchange.getRequestURI().getPath();

        byte[] bodyBytes;
        try (InputStream is = exchange.getRequestBody()) { bodyBytes = is.readAllBytes(); }
        @SuppressWarnings("unchecked")
        Map<String, Object> body = bodyBytes.length > 0
                ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();

        try {
            route(method, path, body, exchange);
        } catch (Exception e) {
            sendJson(exchange, 500, Map.of("__type", "ServiceException", "message",
                    e.getMessage() != null ? e.getMessage() : "Internal error"));
        }
    }

    @SuppressWarnings("unchecked")
    private void route(String method, String path, Map<String, Object> body, HttpExchange exchange) throws IOException {
        String[] parts = path.replaceAll("^/+|/+$", "").split("/", -1);

        // POST /restapis
        if ("POST".equals(method) && parts.length == 1 && "restapis".equals(parts[0])) {
            handleCreateRestApi(body, exchange);
            return;
        }
        // GET /restapis
        if ("GET".equals(method) && parts.length == 1 && "restapis".equals(parts[0])) {
            List<Map<String, Object>> items = new ArrayList<>(apis.values());
            sendJson(exchange, 200, Map.of("items", items));
            return;
        }
        if (parts.length < 2 || !"restapis".equals(parts[0])) {
            sendError(exchange, 404, "NotFoundException", "Not found: " + path);
            return;
        }
        String apiId = parts[1];

        // GET /restapis/:id
        if ("GET".equals(method) && parts.length == 2) {
            Map<String, Object> api = apis.get(apiId);
            if (api == null) { sendError(exchange, 404, "NotFoundException", "REST API not found"); return; }
            sendJson(exchange, 200, api);
            return;
        }
        // DELETE /restapis/:id
        if ("DELETE".equals(method) && parts.length == 2) {
            if (!apis.containsKey(apiId)) { sendError(exchange, 404, "NotFoundException", "REST API not found"); return; }
            apis.remove(apiId); resources.remove(apiId); deployments.remove(apiId); stages.remove(apiId);
            sendEmpty(exchange, 202);
            return;
        }
        if (parts.length < 3) { sendError(exchange, 404, "NotFoundException", "Not found"); return; }

        String section = parts[2];

        switch (section) {
            case "resources": handleResourceRoute(method, parts, apiId, body, exchange); break;
            case "deployments": handleDeploymentRoute(method, parts, apiId, body, exchange); break;
            case "stages": handleStageRoute(method, parts, apiId, body, exchange); break;
            default: sendError(exchange, 404, "NotFoundException", "Not found: " + path);
        }
    }

    // ── REST APIs ──────────────────────────────────────────────────────────────

    private void handleCreateRestApi(Map<String, Object> body, HttpExchange exchange) throws IOException {
        String id = shortId();
        Map<String, Object> api = new LinkedHashMap<>();
        api.put("id", id);
        api.put("name", body.getOrDefault("name", ""));
        api.put("description", body.getOrDefault("description", ""));
        api.put("createdDate", Instant.now().getEpochSecond());
        api.put("tags", body.getOrDefault("tags", new LinkedHashMap<>()));
        apis.put(id, api);
        // Create root resource
        String rootId = shortId();
        Map<String, Object> root = new LinkedHashMap<>();
        root.put("id", rootId); root.put("pathPart", ""); root.put("path", "/");
        root.put("resourceMethods", new LinkedHashMap<>());
        Map<String, Map<String, Object>> rm = new ConcurrentHashMap<>();
        rm.put(rootId, root);
        resources.put(id, rm);
        deployments.put(id, new ConcurrentHashMap<>());
        stages.put(id, new ConcurrentHashMap<>());
        sendJson(exchange, 201, api);
    }

    // ── Resources ──────────────────────────────────────────────────────────────

    @SuppressWarnings("unchecked")
    private void handleResourceRoute(String method, String[] parts, String apiId, Map<String, Object> body, HttpExchange exchange) throws IOException {
        Map<String, Map<String, Object>> rm = resources.get(apiId);
        if (rm == null) { sendError(exchange, 404, "NotFoundException", "REST API not found"); return; }

        // GET /restapis/:id/resources
        if ("GET".equals(method) && parts.length == 3) {
            sendJson(exchange, 200, Map.of("items", new ArrayList<>(rm.values())));
            return;
        }
        // POST /restapis/:id/resources/:parentId
        if ("POST".equals(method) && parts.length == 4) {
            String parentId = parts[3];
            Map<String, Object> parent = rm.get(parentId);
            if (parent == null) { sendError(exchange, 404, "NotFoundException", "Parent resource not found"); return; }
            String pathPart = (String) body.getOrDefault("pathPart", "");
            String parentPath = (String) parent.get("path");
            String newPath = "/".equals(parentPath) ? "/" + pathPart : parentPath + "/" + pathPart;
            String id = shortId();
            Map<String, Object> resource = new LinkedHashMap<>();
            resource.put("id", id); resource.put("parentId", parentId);
            resource.put("pathPart", pathPart); resource.put("path", newPath);
            resource.put("resourceMethods", new LinkedHashMap<>());
            rm.put(id, resource);
            sendJson(exchange, 201, resource);
            return;
        }
        if (parts.length < 4) { sendError(exchange, 404, "NotFoundException", "Not found"); return; }
        String resourceId = parts[3];

        // GET /restapis/:id/resources/:resourceId
        if ("GET".equals(method) && parts.length == 4) {
            Map<String, Object> resource = rm.get(resourceId);
            if (resource == null) { sendError(exchange, 404, "NotFoundException", "Resource not found"); return; }
            sendJson(exchange, 200, resource);
            return;
        }
        // DELETE /restapis/:id/resources/:resourceId
        if ("DELETE".equals(method) && parts.length == 4) {
            if (!rm.containsKey(resourceId)) { sendError(exchange, 404, "NotFoundException", "Resource not found"); return; }
            rm.remove(resourceId);
            sendEmpty(exchange, 202);
            return;
        }

        // Methods path: /restapis/:id/resources/:rId/methods/:m[/...]
        if (parts.length >= 6 && "methods".equals(parts[4])) {
            handleMethodRoute(method, parts, apiId, resourceId, rm, body, exchange);
            return;
        }

        sendError(exchange, 404, "NotFoundException", "Not found");
    }

    @SuppressWarnings("unchecked")
    private void handleMethodRoute(String method, String[] parts, String apiId, String resourceId,
                                   Map<String, Map<String, Object>> rm, Map<String, Object> body, HttpExchange exchange) throws IOException {
        Map<String, Object> resource = rm.get(resourceId);
        if (resource == null) { sendError(exchange, 404, "NotFoundException", "Resource not found"); return; }
        String httpMethod = parts[5];
        Map<String, Object> resourceMethods = (Map<String, Object>) resource.get("resourceMethods");

        // PUT /…/methods/:m
        if ("PUT".equals(method) && parts.length == 6) {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("httpMethod", httpMethod);
            m.put("authorizationType", body.getOrDefault("authorizationType", "NONE"));
            m.put("apiKeyRequired", body.getOrDefault("apiKeyRequired", false));
            m.put("methodResponses", new LinkedHashMap<>());
            resourceMethods.put(httpMethod, m);
            sendJson(exchange, 201, m);
            return;
        }
        // GET /…/methods/:m
        if ("GET".equals(method) && parts.length == 6) {
            Object m = resourceMethods.get(httpMethod);
            if (m == null) { sendError(exchange, 404, "NotFoundException", "Method not found"); return; }
            sendJson(exchange, 200, m);
            return;
        }
        // DELETE /…/methods/:m
        if ("DELETE".equals(method) && parts.length == 6) {
            resourceMethods.remove(httpMethod);
            sendEmpty(exchange, 204);
            return;
        }

        Map<String, Object> methodObj = (Map<String, Object>) resourceMethods.get(httpMethod);
        if (methodObj == null) { sendError(exchange, 404, "NotFoundException", "Method not found"); return; }

        // PUT /…/methods/:m/responses/:statusCode
        if ("PUT".equals(method) && parts.length == 8 && "responses".equals(parts[6])) {
            Map<String, Object> resp = Map.of("statusCode", parts[7], "responseModels", new LinkedHashMap<>());
            ((Map<String, Object>) methodObj.get("methodResponses")).put(parts[7], resp);
            sendJson(exchange, 201, resp);
            return;
        }

        // PUT /…/methods/:m/integration
        if ("PUT".equals(method) && parts.length == 7 && "integration".equals(parts[6])) {
            Map<String, Object> integ = new LinkedHashMap<>();
            integ.put("type", body.getOrDefault("type", "AWS_PROXY"));
            integ.put("httpMethod", body.getOrDefault("httpMethod", "POST"));
            integ.put("uri", body.getOrDefault("uri", ""));
            integ.put("passthroughBehavior", "WHEN_NO_MATCH");
            integ.put("timeoutInMillis", 29000);
            integ.put("integrationResponses", new LinkedHashMap<>());
            methodObj.put("methodIntegration", integ);
            sendJson(exchange, 201, integ);
            return;
        }
        // GET /…/methods/:m/integration
        if ("GET".equals(method) && parts.length == 7 && "integration".equals(parts[6])) {
            Object integ = methodObj.get("methodIntegration");
            if (integ == null) { sendError(exchange, 404, "NotFoundException", "Integration not found"); return; }
            sendJson(exchange, 200, integ);
            return;
        }
        // DELETE /…/methods/:m/integration
        if ("DELETE".equals(method) && parts.length == 7 && "integration".equals(parts[6])) {
            methodObj.remove("methodIntegration");
            sendEmpty(exchange, 204);
            return;
        }
        // PUT /…/methods/:m/integration/responses/:statusCode
        if ("PUT".equals(method) && parts.length == 9 && "integration".equals(parts[6]) && "responses".equals(parts[7])) {
            Map<String, Object> integ = (Map<String, Object>) methodObj.get("methodIntegration");
            if (integ == null) { sendError(exchange, 404, "NotFoundException", "Integration not found"); return; }
            Map<String, Object> resp = Map.of("statusCode", parts[8], "responseTemplates", new LinkedHashMap<>());
            ((Map<String, Object>) integ.get("integrationResponses")).put(parts[8], resp);
            sendJson(exchange, 201, resp);
            return;
        }

        sendError(exchange, 404, "NotFoundException", "Not found");
    }

    // ── Deployments ────────────────────────────────────────────────────────────

    private void handleDeploymentRoute(String method, String[] parts, String apiId, Map<String, Object> body, HttpExchange exchange) throws IOException {
        Map<String, Map<String, Object>> dm = deployments.get(apiId);
        if (dm == null) { sendError(exchange, 404, "NotFoundException", "REST API not found"); return; }

        if ("POST".equals(method) && parts.length == 3) {
            String id = shortId();
            String stageName = (String) body.get("stageName");
            Map<String, Object> d = new LinkedHashMap<>();
            d.put("id", id); d.put("description", body.getOrDefault("description", ""));
            d.put("createdDate", Instant.now().getEpochSecond());
            if (stageName != null) d.put("stageName", stageName);
            dm.put(id, d);
            if (stageName != null) {
                Map<String, Map<String, Object>> sm = stages.get(apiId);
                if (sm != null) {
                    Map<String, Object> stage = sm.computeIfAbsent(stageName, k -> {
                        Map<String, Object> s = new LinkedHashMap<>();
                        s.put("stageName", stageName); s.put("deploymentId", id);
                        s.put("description", body.getOrDefault("description", ""));
                        s.put("createdDate", Instant.now().getEpochSecond());
                        s.put("lastUpdatedDate", Instant.now().getEpochSecond());
                        s.put("variables", new LinkedHashMap<>()); s.put("tags", new LinkedHashMap<>());
                        return s;
                    });
                    stage.put("deploymentId", id);
                    stage.put("lastUpdatedDate", Instant.now().getEpochSecond());
                }
            }
            sendJson(exchange, 201, d);
            return;
        }
        if ("GET".equals(method) && parts.length == 3) {
            sendJson(exchange, 200, Map.of("items", new ArrayList<>(dm.values())));
            return;
        }
        if (parts.length < 4) { sendError(exchange, 404, "NotFoundException", "Not found"); return; }
        String deploymentId = parts[3];
        if ("GET".equals(method)) {
            Map<String, Object> d = dm.get(deploymentId);
            if (d == null) { sendError(exchange, 404, "NotFoundException", "Deployment not found"); return; }
            sendJson(exchange, 200, d);
            return;
        }
        if ("DELETE".equals(method)) {
            if (!dm.containsKey(deploymentId)) { sendError(exchange, 404, "NotFoundException", "Deployment not found"); return; }
            dm.remove(deploymentId);
            sendEmpty(exchange, 202);
            return;
        }
        sendError(exchange, 404, "NotFoundException", "Not found");
    }

    // ── Stages ─────────────────────────────────────────────────────────────────

    private void handleStageRoute(String method, String[] parts, String apiId, Map<String, Object> body, HttpExchange exchange) throws IOException {
        Map<String, Map<String, Object>> sm = stages.get(apiId);
        if (sm == null) { sendError(exchange, 404, "NotFoundException", "REST API not found"); return; }

        if ("POST".equals(method) && parts.length == 3) {
            String stageName = (String) body.get("stageName");
            Map<String, Object> stage = new LinkedHashMap<>();
            stage.put("stageName", stageName);
            stage.put("deploymentId", body.getOrDefault("deploymentId", ""));
            stage.put("description", body.getOrDefault("description", ""));
            stage.put("createdDate", Instant.now().getEpochSecond());
            stage.put("lastUpdatedDate", Instant.now().getEpochSecond());
            stage.put("variables", new LinkedHashMap<>());
            stage.put("tags", new LinkedHashMap<>());
            sm.put(stageName, stage);
            sendJson(exchange, 201, stage);
            return;
        }
        if ("GET".equals(method) && parts.length == 3) {
            sendJson(exchange, 200, Map.of("item", new ArrayList<>(sm.values())));
            return;
        }
        if (parts.length < 4) { sendError(exchange, 404, "NotFoundException", "Not found"); return; }
        String stageName = parts[3];
        if ("GET".equals(method)) {
            Map<String, Object> stage = sm.get(stageName);
            if (stage == null) { sendError(exchange, 404, "NotFoundException", "Stage not found"); return; }
            sendJson(exchange, 200, stage);
            return;
        }
        if ("DELETE".equals(method)) {
            if (!sm.containsKey(stageName)) { sendError(exchange, 404, "NotFoundException", "Stage not found"); return; }
            sm.remove(stageName);
            sendEmpty(exchange, 202);
            return;
        }
        if ("PATCH".equals(method) || "PUT".equals(method)) {
            Map<String, Object> stage = sm.get(stageName);
            if (stage == null) { sendError(exchange, 404, "NotFoundException", "Stage not found"); return; }
            if (body.containsKey("description")) stage.put("description", body.get("description"));
            if (body.containsKey("deploymentId")) stage.put("deploymentId", body.get("deploymentId"));
            stage.put("lastUpdatedDate", Instant.now().getEpochSecond());
            sendJson(exchange, 200, stage);
            return;
        }
        sendError(exchange, 404, "NotFoundException", "Not found");
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private static String shortId() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 10);
    }

    private static void sendJson(HttpExchange exchange, int status, Object payload) throws IOException {
        byte[] bytes = MAPPER.writeValueAsBytes(payload);
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
    }

    private static void sendError(HttpExchange exchange, int status, String type, String msg) throws IOException {
        sendJson(exchange, status, Map.of("__type", type, "message", msg));
    }

    private static void sendEmpty(HttpExchange exchange, int status) throws IOException {
        exchange.sendResponseHeaders(status, -1);
        exchange.getResponseBody().close();
    }
}
