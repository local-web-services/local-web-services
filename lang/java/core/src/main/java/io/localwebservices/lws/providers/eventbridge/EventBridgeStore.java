package io.localwebservices.lws.providers.eventbridge;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory EventBridge state storage. */
public class EventBridgeStore {

  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  public final Map<String, Map<String, Object>> eventBuses = new ConcurrentHashMap<>();
  public final Map<String, Map<String, Object>> rules = new ConcurrentHashMap<>();
  public final Map<String, List<Map<String, Object>>> ruleTargets = new ConcurrentHashMap<>();
  public final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

  public EventBridgeStore() {
    initDefaultBus();
  }

  private void initDefaultBus() {
    eventBuses.put(
        "default",
        new LinkedHashMap<>(
            Map.of(
                "Name",
                "default",
                "Arn",
                "arn:aws:events:" + REGION + ":" + ACCOUNT + ":event-bus/default")));
  }

  public void reset() {
    eventBuses.clear();
    initDefaultBus();
    rules.clear();
    ruleTargets.clear();
    resourceTags.clear();
  }
}
