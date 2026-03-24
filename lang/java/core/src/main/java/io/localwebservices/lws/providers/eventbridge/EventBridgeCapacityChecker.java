package io.localwebservices.lws.providers.eventbridge;

import io.localwebservices.lws.ServerState;
import java.util.List;
import java.util.Map;

/** Checks whether EventBridge target service capacity is exhausted. */
class EventBridgeCapacityChecker {

  private EventBridgeCapacityChecker() {}

  static boolean isExhausted(EventBridgeStore store, ServerState state, String busName) {
    if (state.getCapacityConfig("stepfunctions").isExhausted()
        || state.getCapacityConfig("sqs").isExhausted()
        || state.getCapacityConfig("sns").isExhausted()
        || state.getCapacityConfig("lambda").isExhausted()) {
      return true;
    }
    for (Map<String, Object> rule : store.rules.values()) {
      if (!busName.equals(rule.getOrDefault("EventBusName", "default"))) continue;
      if (!"ENABLED".equals(rule.getOrDefault("State", "ENABLED"))) continue;
      String ruleName = (String) rule.get("Name");
      List<Map<String, Object>> targets = store.ruleTargets.getOrDefault(ruleName, List.of());
      for (Map<String, Object> tgt : targets) {
        String arn = (String) tgt.getOrDefault("Arn", "");
        String service = resolveService(arn);
        if (service != null && state.getCapacityConfig(service).isExhausted()) return true;
      }
    }
    return false;
  }

  private static String resolveService(String arn) {
    if (arn == null) return null;
    if (arn.contains(":sqs:")) return "sqs";
    if (arn.contains(":sns:")) return "sns";
    if (arn.contains(":states:")) return "stepfunctions";
    if (arn.contains(":lambda:")) return "lambda";
    return null;
  }
}
