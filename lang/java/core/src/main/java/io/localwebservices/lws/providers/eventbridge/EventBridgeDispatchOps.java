package io.localwebservices.lws.providers.eventbridge;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.providers.sns.SnsHandler;
import io.localwebservices.lws.providers.sqs.SqsHandler;
import io.localwebservices.lws.providers.stepfunctions.StepFunctionsHandler;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Handles event dispatch for EventBridge. Dispatches events to SQS queues, SNS topics, and Step
 * Functions state machines based on rule targets. Also handles PutEvents wire-protocol logic.
 */
class EventBridgeDispatchOps {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final EventBridgeStore store;
  private final ServerState state;
  private SqsHandler sqsHandler;
  private SnsHandler snsHandler;
  private StepFunctionsHandler stepFunctionsHandler;

  EventBridgeDispatchOps(EventBridgeStore store, ServerState state) {
    this.store = store;
    this.state = state;
  }

  void setSqsHandler(SqsHandler sqsHandler) {
    this.sqsHandler = sqsHandler;
  }

  void setSnsHandler(SnsHandler snsHandler) {
    this.snsHandler = snsHandler;
  }

  void setStepFunctionsHandler(StepFunctionsHandler stepFunctionsHandler) {
    this.stepFunctionsHandler = stepFunctionsHandler;
  }

  /**
   * Puts events programmatically (used by StepFunctions service task bridges). The params map must
   * contain "Entries" as a List of event entry maps. Returns a map with "FailedEntryCount" and
   * "Entries".
   */
  @SuppressWarnings("unchecked")
  Map<String, Object> executePutEvents(Map<String, Object> params) {
    List<Map<String, Object>> entries =
        (List<Map<String, Object>>) params.getOrDefault("Entries", List.of());
    List<Map<String, Object>> resultEntries = new ArrayList<>();
    for (int i = 0; i < entries.size(); i++) {
      resultEntries.add(Map.of("EventId", UUID.randomUUID().toString()));
    }
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("FailedEntryCount", 0);
    result.put("Entries", resultEntries);
    return result;
  }

  /**
   * Processes PutEvents entries. Returns a result map with "FailedEntryCount", "Entries", and
   * "allFailed" flag for the handler to decide on the HTTP response code.
   */
  @SuppressWarnings("unchecked")
  Map<String, Object> processPutEvents(List<Map<String, Object>> entries) {
    List<Map<String, Object>> resultEntries = new ArrayList<>();
    int failedCount = 0;
    for (Map<String, Object> entry : entries) {
      String busName = (String) entry.getOrDefault("EventBusName", "default");
      if (!store.eventBuses.containsKey(busName)) {
        failedCount++;
        resultEntries.add(
            Map.of(
                "ErrorCode",
                "ResourceNotFoundException",
                "ErrorMessage",
                "Event bus " + busName + " does not exist."));
        continue;
      }
      boolean hasEnabledRuleWithTarget =
          store.rules.values().stream()
              .filter(r -> busName.equals(r.getOrDefault("EventBusName", "default")))
              .filter(r -> "ENABLED".equals(r.getOrDefault("State", "ENABLED")))
              .anyMatch(
                  r -> {
                    String ruleName = (String) r.get("Name");
                    List<Map<String, Object>> targets =
                        store.ruleTargets.getOrDefault(ruleName, List.of());
                    return !targets.isEmpty();
                  });
      if (!hasEnabledRuleWithTarget) {
        failedCount++;
        resultEntries.add(
            Map.of(
                "ErrorCode",
                "ResourceNotFoundException",
                "ErrorMessage",
                "No enabled rule with targets for event bus " + busName));
      } else if (EventBridgeCapacityChecker.isExhausted(store, state, busName)) {
        failedCount++;
        resultEntries.add(
            Map.of(
                "ErrorCode",
                "ResourceNotFoundException",
                "ErrorMessage",
                "Target service has no available capacity."));
      } else {
        resultEntries.add(Map.of("EventId", UUID.randomUUID().toString()));
        dispatchEventToTargets(busName, entry);
      }
    }
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("FailedEntryCount", failedCount);
    result.put("Entries", resultEntries);
    result.put("allFailed", failedCount > 0 && failedCount == entries.size());
    return result;
  }

  void dispatchEventToTargets(String busName, Map<String, Object> event) {
    String eventJson;
    try {
      eventJson = MAPPER.writeValueAsString(event);
    } catch (Exception e) {
      eventJson = "{}";
    }
    for (Map<String, Object> rule : store.rules.values()) {
      if (!busName.equals(rule.getOrDefault("EventBusName", "default"))) continue;
      if (!"ENABLED".equals(rule.getOrDefault("State", "ENABLED"))) continue;
      String ruleName = (String) rule.get("Name");
      List<Map<String, Object>> targets = store.ruleTargets.getOrDefault(ruleName, List.of());
      for (Map<String, Object> target : targets) {
        String arn = (String) target.getOrDefault("Arn", "");
        dispatchToTarget(arn, eventJson);
      }
    }
  }

  private void dispatchToTarget(String arn, String eventJson) {
    if (arn.contains(":sqs:") && sqsHandler != null) {
      String queueName = arn.substring(arn.lastIndexOf(':') + 1);
      sqsHandler.deliverToQueue(queueName, eventJson);
    } else if (arn.contains(":sns:") && snsHandler != null) {
      snsHandler.publishToTopic(arn, eventJson);
    } else if (arn.contains(":states:") && stepFunctionsHandler != null) {
      stepFunctionsHandler.startExecution(arn, eventJson);
    }
  }
}
