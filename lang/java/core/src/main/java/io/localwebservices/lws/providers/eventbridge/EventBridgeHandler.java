package io.localwebservices.lws.providers.eventbridge;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** EventBridge wire-protocol HTTP handler. */
public class EventBridgeHandler implements HttpHandler {

    private static final ObjectMapper MAPPER = new ObjectMapper();
    private static final String ACCOUNT = "000000000000";
    private static final String REGION = "us-east-1";

    private final ServerState state;
    private final Map<String, Map<String, Object>> eventBuses = new ConcurrentHashMap<>();
    private final Map<String, Map<String, Object>> rules = new ConcurrentHashMap<>();
    private final Map<String, List<Map<String, Object>>> ruleTargets = new ConcurrentHashMap<>();
    private final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

    public EventBridgeHandler(ServerState state) {
        this.state = state;
        // Default event bus
        eventBuses.put("default", new LinkedHashMap<>(Map.of(
            "Name", "default",
            "Arn", "arn:aws:events:" + REGION + ":" + ACCOUNT + ":event-bus/default"
        )));
        state.resetCallbacks.add(this::reset);
    }

    private void reset() {
        eventBuses.clear();
        eventBuses.put("default", new LinkedHashMap<>(Map.of(
            "Name", "default",
            "Arn", "arn:aws:events:" + REGION + ":" + ACCOUNT + ":event-bus/default"
        )));
        rules.clear();
        ruleTargets.clear();
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
        Map<String, Object> body = bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : Map.of();

        try {
            if (IamMiddleware.applyIamAuth(state, "events", operation, exchange, false)) return;
            if (ChaosMiddleware.applyChaos(state, "events", operation, exchange, false)) return;

            handleOperation(operation, body, exchange);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
        } catch (Exception e) {
            sendJson(exchange, 400, Map.of("__type", "ValidationException", "message", e.getMessage() != null ? e.getMessage() : "Error"));
        }
    }

    @SuppressWarnings("unchecked")
    private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange) throws IOException {
        switch (operation) {
            case "PutEvents": {
                List<Map<String, Object>> entries = (List<Map<String, Object>>) body.getOrDefault("Entries", List.of());
                List<Map<String, Object>> resultEntries = new ArrayList<>();
                int failedCount = 0;
                for (Map<String, Object> entry : entries) {
                    String busName = (String) entry.getOrDefault("EventBusName", "default");
                    if (!eventBuses.containsKey(busName)) {
                        failedCount++;
                        resultEntries.add(Map.of("ErrorCode", "ResourceNotFoundException", "ErrorMessage", "Event bus " + busName + " does not exist."));
                        continue;
                    }
                    // Check if any ENABLED rule is associated with this bus and has targets
                    boolean hasEnabledRuleWithTarget = rules.values().stream()
                        .filter(r -> busName.equals(r.getOrDefault("EventBusName", "default")))
                        .filter(r -> "ENABLED".equals(r.getOrDefault("State", "ENABLED")))
                        .anyMatch(r -> {
                            String ruleName = (String) r.get("Name");
                            List<Map<String, Object>> targets = ruleTargets.getOrDefault(ruleName, List.of());
                            return !targets.isEmpty();
                        });
                    if (!hasEnabledRuleWithTarget) {
                        failedCount++;
                        resultEntries.add(Map.of("ErrorCode", "ResourceNotFoundException", "ErrorMessage", "No enabled rule with targets for event bus " + busName));
                    } else {
                        resultEntries.add(Map.of("EventId", UUID.randomUUID().toString()));
                    }
                }
                if (failedCount > 0 && failedCount == entries.size()) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "No enabled rule with targets for event bus."));
                    break;
                }
                sendJson(exchange, 200, Map.of("FailedEntryCount", failedCount, "Entries", resultEntries));
                break;
            }
            case "CreateEventBus": {
                String name = (String) body.get("Name");
                if (eventBuses.containsKey(name)) {
                    sendJson(exchange, 400, Map.of("__type", "EventBusAlreadyExists", "message", "Event bus already exists."));
                    break;
                }
                String arn = "arn:aws:events:" + REGION + ":" + ACCOUNT + ":event-bus/" + name;
                eventBuses.put(name, new LinkedHashMap<>(Map.of("Name", name, "Arn", arn)));
                sendJson(exchange, 200, Map.of("EventBusArn", arn));
                break;
            }
            case "DeleteEventBus": {
                String busName = (String) body.get("Name");
                if ("default".equals(busName)) {
                    sendJson(exchange, 400, Map.of("__type", "OperationDisabledException", "message", "Operation not permitted on default event bus."));
                    break;
                }
                if (!eventBuses.containsKey(busName)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Event bus " + busName + " does not exist."));
                    break;
                }
                // Check if bus has associated rules
                boolean hasRules = rules.values().stream()
                    .anyMatch(r -> busName.equals(r.getOrDefault("EventBusName", "default")));
                if (hasRules) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Event bus " + busName + " has associated rules."));
                    break;
                }
                eventBuses.remove(busName);
                sendJson(exchange, 200, Map.of());
                break;
            }
            case "ListEventBuses": {
                List<Map<String, Object>> list = new ArrayList<>(eventBuses.values());
                sendJson(exchange, 200, Map.of("EventBuses", list));
                break;
            }
            case "DescribeEventBus": {
                String name = (String) body.getOrDefault("Name", "default");
                Map<String, Object> bus = eventBuses.get(name);
                if (bus == null) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Event bus " + name + " does not exist."));
                    break;
                }
                sendJson(exchange, 200, bus);
                break;
            }
            case "PutRule": {
                String name = (String) body.get("Name");
                String busName = (String) body.getOrDefault("EventBusName", "default");
                if (!eventBuses.containsKey(busName)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Event bus " + busName + " does not exist."));
                    break;
                }
                if (rules.containsKey(name)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceAlreadyExistsException", "message", "Rule " + name + " already exists."));
                    break;
                }
                String arn = "arn:aws:events:" + REGION + ":" + ACCOUNT + ":rule/" + busName + "/" + name;
                Map<String, Object> rule = new LinkedHashMap<>(body);
                rule.put("Arn", arn);
                rule.put("State", body.getOrDefault("State", "ENABLED"));
                rules.put(name, rule);
                sendJson(exchange, 200, Map.of("RuleArn", arn));
                break;
            }
            case "DeleteRule": {
                String name = (String) body.get("Name");
                if (!rules.containsKey(name)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Rule " + name + " does not exist."));
                    break;
                }
                List<Map<String, Object>> targets = ruleTargets.getOrDefault(name, List.of());
                if (!targets.isEmpty()) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceInUseException", "message", "Rule " + name + " has active targets and cannot be deleted."));
                    break;
                }
                rules.remove(name);
                sendJson(exchange, 200, Map.of());
                break;
            }
            case "DescribeRule": {
                String name = (String) body.get("Name");
                Map<String, Object> rule = rules.get(name);
                if (rule == null) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Rule " + name + " does not exist."));
                    break;
                }
                sendJson(exchange, 200, rule);
                break;
            }
            case "ListRules": {
                String busName = (String) body.getOrDefault("EventBusName", "default");
                if (!eventBuses.containsKey(busName)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Event bus " + busName + " does not exist."));
                    break;
                }
                sendJson(exchange, 200, Map.of("Rules", new ArrayList<>(rules.values())));
                break;
            }
            case "PutTargets": {
                String ruleName = (String) body.get("Rule");
                if (!rules.containsKey(ruleName)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Rule " + ruleName + " does not exist."));
                    break;
                }
                List<Map<String, Object>> targets = (List<Map<String, Object>>) body.getOrDefault("Targets", List.of());
                ruleTargets.computeIfAbsent(ruleName, k -> new ArrayList<>()).addAll(targets);
                sendJson(exchange, 200, Map.of("FailedEntryCount", 0, "FailedEntries", List.of()));
                break;
            }
            case "RemoveTargets": {
                String ruleName = (String) body.get("Rule");
                if (!rules.containsKey(ruleName)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Rule " + ruleName + " does not exist."));
                    break;
                }
                List<String> ids = (List<String>) body.getOrDefault("Ids", List.of());
                List<Map<String, Object>> targets = ruleTargets.getOrDefault(ruleName, new ArrayList<>());
                // Check all targets exist before removing
                List<String> notFound = new ArrayList<>();
                for (String id : ids) {
                    boolean found = targets.stream().anyMatch(t -> id.equals(t.get("Id")));
                    if (!found) notFound.add(id);
                }
                if (!notFound.isEmpty()) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Target(s) not found: " + notFound));
                    break;
                }
                targets.removeIf(t -> ids.contains(t.get("Id")));
                sendJson(exchange, 200, Map.of("FailedEntryCount", 0, "FailedEntries", List.of()));
                break;
            }
            case "ListTargetsByRule": {
                String ruleName = (String) body.get("Rule");
                if (!rules.containsKey(ruleName)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Rule " + ruleName + " does not exist."));
                    break;
                }
                sendJson(exchange, 200, Map.of("Targets", ruleTargets.getOrDefault(ruleName, List.of())));
                break;
            }
            case "EnableRule": {
                String name = (String) body.get("Name");
                if (!rules.containsKey(name)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Rule " + name + " does not exist."));
                    break;
                }
                if ("ENABLED".equals(rules.get(name).get("State"))) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Rule " + name + " is already enabled."));
                    break;
                }
                rules.get(name).put("State", "ENABLED");
                sendJson(exchange, 200, Map.of());
                break;
            }
            case "DisableRule": {
                String name = (String) body.get("Name");
                if (!rules.containsKey(name)) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Rule " + name + " does not exist."));
                    break;
                }
                if ("DISABLED".equals(rules.get(name).get("State"))) {
                    sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", "Rule " + name + " is already disabled."));
                    break;
                }
                rules.get(name).put("State", "DISABLED");
                sendJson(exchange, 200, Map.of());
                break;
            }
            case "ListTagsForResource": {
                String resourceArn = (String) body.get("ResourceARN");
                List<Map<String, String>> tags = resourceTags.getOrDefault(resourceArn, List.of());
                sendJson(exchange, 200, Map.of("Tags", tags));
                break;
            }
            case "TagResource": {
                String resourceArn = (String) body.get("ResourceARN");
                List<Map<String, Object>> newTags = (List<Map<String, Object>>) body.getOrDefault("Tags", List.of());
                List<Map<String, String>> existing = resourceTags.computeIfAbsent(resourceArn, k -> new ArrayList<>());
                for (Map<String, Object> tag : newTags) {
                    existing.add(Map.of("Key", (String) tag.get("Key"), "Value", (String) tag.get("Value")));
                }
                sendJson(exchange, 200, Map.of());
                break;
            }
            case "UntagResource": {
                String resourceArn = (String) body.get("ResourceARN");
                List<String> tagKeys = (List<String>) body.getOrDefault("TagKeys", List.of());
                List<Map<String, String>> existing = resourceTags.getOrDefault(resourceArn, new ArrayList<>());
                existing.removeIf(t -> tagKeys.contains(t.get("Key")));
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
        exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
    }
}
