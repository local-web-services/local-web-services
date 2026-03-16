package io.localwebservices.lws.providers.stepfunctions;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.FakeMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** Step Functions wire-protocol HTTP handler. */
public class StepFunctionsHandler implements HttpHandler {

    private static final ObjectMapper MAPPER = new ObjectMapper();
    private static final String ACCOUNT = "000000000000";
    private static final String REGION = "us-east-1";
    private static final String TARGET_PREFIX = "AmazonStates.";

    private final ServerState state;
    private final Map<String, Map<String, Object>> stateMachines = new ConcurrentHashMap<>();
    private final Map<String, Map<String, Object>> executions = new ConcurrentHashMap<>();
    private final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

    public StepFunctionsHandler(ServerState state) {
        this.state = state;
        state.resetCallbacks.add(this::reset);
    }

    private void reset() {
        stateMachines.clear();
        executions.clear();
        resourceTags.clear();
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
        if (target == null) target = "";
        String operation = target.contains(".") ? target.substring(target.lastIndexOf('.') + 1) : target;

        byte[] bodyBytes;
        try (InputStream is = exchange.getRequestBody()) { bodyBytes = is.readAllBytes(); }
        @SuppressWarnings("unchecked")
        Map<String, Object> body = bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();

        long startMs = System.currentTimeMillis();
        int[] statusHolder = {200};
        try {
            if (IamMiddleware.applyIamAuth(state, "states", operation, exchange, false)) { statusHolder[0] = 403; return; }
            if (FakeMiddleware.applyFake(state, "stepfunctions", operation, exchange)) { statusHolder[0] = 200; return; }
            if (ChaosMiddleware.applyChaos(state, "stepfunctions", operation, exchange, false)) { statusHolder[0] = 500; return; }

            handleOperation(operation, body, exchange);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            statusHolder[0] = 500;
            sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
        } catch (Exception e) {
            statusHolder[0] = 400;
            sendJson(exchange, 400, Map.of("__type", "ValidationException", "message", e.getMessage() != null ? e.getMessage() : "Error"));
        } finally {
            double durationMs = System.currentTimeMillis() - startMs;
            Map<String, Object> logEntry = new LinkedHashMap<>();
            logEntry.put("service", "stepfunctions");
            logEntry.put("handler", operation);
            logEntry.put("level", statusHolder[0] >= 500 ? "ERROR" : "INFO");
            logEntry.put("status_code", statusHolder[0]);
            logEntry.put("duration_ms", durationMs);
            logEntry.put("timestamp", Instant.now().toString());
            state.addLog(logEntry);
        }
    }

    @SuppressWarnings("unchecked")
    private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange) throws IOException {
        switch (operation) {
            case "CreateStateMachine": {
                String name = (String) body.get("name");
                String arn = "arn:aws:states:" + REGION + ":" + ACCOUNT + ":stateMachine:" + name;
                if (stateMachines.containsKey(arn)) {
                    sendJson(exchange, 400, Map.of("__type", "StateMachineAlreadyExists", "message", "State Machine Already Exists"));
                    break;
                }
                Map<String, Object> sm = new LinkedHashMap<>(body);
                sm.put("stateMachineArn", arn);
                sm.put("creationDate", Instant.now().getEpochSecond() * 1.0);
                sm.put("status", "ACTIVE");
                stateMachines.put(arn, sm);
                sendJson(exchange, 200, Map.of("stateMachineArn", arn, "creationDate", sm.getOrDefault("creationDate", 0.0)));
                break;
            }
            case "DeleteStateMachine": {
                String arn = (String) body.get("stateMachineArn");
                if (!stateMachines.containsKey(arn)) {
                    sendJson(exchange, 400, Map.of("__type", "StateMachineDoesNotExist", "message", "State machine does not exist: " + arn));
                    break;
                }
                stateMachines.remove(arn);
                sendJson(exchange, 200, Map.of());
                break;
            }
            case "DescribeStateMachine": {
                String arn = (String) body.get("stateMachineArn");
                Map<String, Object> sm = stateMachines.get(arn);
                if (sm == null) {
                    sendJson(exchange, 400, Map.of("__type", "StateMachineDoesNotExist", "message", "State machine does not exist: " + arn));
                    return;
                }
                sendJson(exchange, 200, sm);
                break;
            }
            case "ListStateMachines": {
                List<Map<String, Object>> list = new ArrayList<>();
                for (Map<String, Object> sm : stateMachines.values()) {
                    list.add(Map.of("stateMachineArn", sm.get("stateMachineArn"),
                        "name", sm.get("name"), "creationDate", sm.get("creationDate"),
                        "type", sm.getOrDefault("type", "STANDARD")));
                }
                sendJson(exchange, 200, Map.of("stateMachines", list));
                break;
            }
            case "UpdateStateMachine": {
                String arn = (String) body.get("stateMachineArn");
                if (stateMachines.containsKey(arn)) {
                    stateMachines.get(arn).putAll(body);
                }
                sendJson(exchange, 200, Map.of("updateDate", Instant.now().getEpochSecond() * 1.0));
                break;
            }
            case "ValidateStateMachineDefinition": {
                sendJson(exchange, 200, Map.of("result", "OK", "diagnostics", List.of()));
                break;
            }
            case "ListStateMachineVersions": {
                String smArn = (String) body.get("stateMachineArn");
                if (!stateMachines.containsKey(smArn)) {
                    sendJson(exchange, 400, Map.of("__type", "StateMachineDoesNotExist", "message", "State machine does not exist: " + smArn));
                    break;
                }
                sendJson(exchange, 200, Map.of("stateMachineVersions", List.of()));
                break;
            }
            case "StartExecution": {
                String smArn = (String) body.get("stateMachineArn");
                if (!stateMachines.containsKey(smArn)) {
                    sendJson(exchange, 400, Map.of("__type", "StateMachineDoesNotExist", "message", "State machine does not exist: " + smArn));
                    return;
                }
                String execName = body.containsKey("name") ? (String) body.get("name") : UUID.randomUUID().toString();
                String execArn = "arn:aws:states:" + REGION + ":" + ACCOUNT + ":execution:" +
                    (smArn.contains(":") ? smArn.substring(smArn.lastIndexOf(':') + 1) : smArn) + ":" + execName;
                double startDate = Instant.now().getEpochSecond() * 1.0;

                // Simple pass-through execution: copy input to output
                String input = (String) body.getOrDefault("input", "{}");
                Map<String, Object> exec = new LinkedHashMap<>();
                exec.put("executionArn", execArn);
                exec.put("stateMachineArn", smArn);
                exec.put("name", execName);
                exec.put("status", "SUCCEEDED");
                exec.put("startDate", startDate);
                exec.put("stopDate", startDate);
                exec.put("input", input);
                exec.put("output", input);
                executions.put(execArn, exec);

                sendJson(exchange, 200, Map.of("executionArn", execArn, "startDate", startDate));
                break;
            }
            case "StartSyncExecution": {
                String smArn = (String) body.get("stateMachineArn");
                if (!stateMachines.containsKey(smArn)) {
                    sendJson(exchange, 400, Map.of("__type", "StateMachineDoesNotExist", "message", "State machine does not exist: " + smArn));
                    break;
                }
                String execName = body.containsKey("name") ? (String) body.get("name") : UUID.randomUUID().toString();
                String execArn = "arn:aws:states:" + REGION + ":" + ACCOUNT + ":express:" +
                    (smArn.contains(":") ? smArn.substring(smArn.lastIndexOf(':') + 1) : smArn) + ":" + execName;
                double now = Instant.now().getEpochSecond() * 1.0;
                String input = (String) body.getOrDefault("input", "{}");
                sendJson(exchange, 200, Map.of(
                    "executionArn", execArn,
                    "stateMachineArn", smArn,
                    "name", execName,
                    "status", "SUCCEEDED",
                    "startDate", now,
                    "stopDate", now,
                    "input", input,
                    "output", input
                ));
                break;
            }
            case "StopExecution": {
                String execArn = (String) body.get("executionArn");
                if (!executions.containsKey(execArn)) {
                    sendJson(exchange, 400, Map.of("__type", "ExecutionDoesNotExist", "message", "Execution does not exist: " + execArn));
                    break;
                }
                double stopDate = Instant.now().getEpochSecond() * 1.0;
                executions.get(execArn).put("status", "ABORTED");
                executions.get(execArn).put("stopDate", stopDate);
                sendJson(exchange, 200, Map.of("stopDate", stopDate));
                break;
            }
            case "DescribeExecution": {
                String execArn = (String) body.get("executionArn");
                Map<String, Object> exec = executions.get(execArn);
                if (exec == null) {
                    exec = Map.of("executionArn", execArn, "status", "RUNNING",
                        "startDate", Instant.now().getEpochSecond() * 1.0, "input", "{}");
                }
                sendJson(exchange, 200, exec);
                break;
            }
            case "ListExecutions": {
                String smArn = (String) body.get("stateMachineArn");
                if (!stateMachines.containsKey(smArn)) {
                    sendJson(exchange, 400, Map.of("__type", "StateMachineDoesNotExist", "message", "State machine does not exist: " + smArn));
                    break;
                }
                List<Map<String, Object>> list = new ArrayList<>();
                for (Map<String, Object> exec : executions.values()) {
                    if (smArn.equals(exec.get("stateMachineArn"))) {
                        list.add(Map.of("executionArn", exec.get("executionArn"),
                            "stateMachineArn", exec.get("stateMachineArn"),
                            "name", exec.get("name"),
                            "status", exec.get("status"),
                            "startDate", exec.get("startDate")));
                    }
                }
                sendJson(exchange, 200, Map.of("executions", list));
                break;
            }
            case "GetExecutionHistory": {
                String execArn = (String) body.get("executionArn");
                if (execArn == null || !executions.containsKey(execArn)) {
                    sendJson(exchange, 400, Map.of("__type", "ExecutionDoesNotExist", "message", "Execution does not exist: " + execArn));
                    break;
                }
                sendJson(exchange, 200, Map.of("events", List.of()));
                break;
            }
            case "ListTagsForResource": {
                String resourceArn = (String) body.get("resourceArn");
                if (!stateMachines.containsKey(resourceArn)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFound", "message", "Resource not found: " + resourceArn));
                    break;
                }
                List<Map<String, String>> tags = resourceTags.getOrDefault(resourceArn, List.of());
                sendJson(exchange, 200, Map.of("tags", tags));
                break;
            }
            case "TagResource": {
                String resourceArn = (String) body.get("resourceArn");
                if (!stateMachines.containsKey(resourceArn)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFound", "message", "Resource not found: " + resourceArn));
                    break;
                }
                List<Map<String, Object>> newTags = (List<Map<String, Object>>) body.getOrDefault("tags", List.of());
                List<Map<String, String>> existing = resourceTags.computeIfAbsent(resourceArn, k -> new ArrayList<>());
                for (Map<String, Object> tag : newTags) {
                    existing.add(Map.of("key", (String) tag.get("key"), "value", (String) tag.get("value")));
                }
                sendJson(exchange, 200, Map.of());
                break;
            }
            case "UntagResource": {
                String resourceArn = (String) body.get("resourceArn");
                if (!stateMachines.containsKey(resourceArn)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFound", "message", "Resource not found: " + resourceArn));
                    break;
                }
                List<String> tagKeys = (List<String>) body.getOrDefault("tagKeys", List.of());
                List<Map<String, String>> existing = resourceTags.getOrDefault(resourceArn, new ArrayList<>());
                boolean allFound = tagKeys.stream().allMatch(k -> existing.stream().anyMatch(t -> k.equals(t.get("key"))));
                if (!allFound) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFound", "message", "Tag not found on resource: " + resourceArn));
                    break;
                }
                existing.removeIf(t -> tagKeys.contains(t.get("key")));
                sendJson(exchange, 200, Map.of());
                break;
            }
            default: {
                sendJson(exchange, 400, Map.of("__type", "UnknownOperationException", "message", "Not implemented: " + operation));
            }
        }
    }

    private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
        byte[] bytes = MAPPER.writeValueAsBytes(body);
        exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.0");
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
    }
}
