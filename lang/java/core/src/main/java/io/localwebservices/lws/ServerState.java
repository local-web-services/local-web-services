package io.localwebservices.lws;

import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;

/** Shared mutable server state. */
public class ServerState {

  // chaos rules: service -> operation -> config map
  public final Map<String, Map<String, Map<String, Object>>> chaosRules =
      Collections.synchronizedMap(new LinkedHashMap<>());

  // fake response rules: service -> config (enabled, rules list)
  public final Map<String, Map<String, Object>> fakeRules =
      Collections.synchronizedMap(new LinkedHashMap<>());

  // IAM config
  public volatile boolean iamEnforce = false;
  public volatile String iamDefaultIdentity = null;
  public final Map<String, Object> iamIdentities =
      Collections.synchronizedMap(new LinkedHashMap<>());
  public final Map<String, Object> iamResourcePolicies =
      Collections.synchronizedMap(new LinkedHashMap<>());

  // log buffer (max 500 entries)
  public final List<Map<String, Object>> logBuffer = new CopyOnWriteArrayList<>();

  // Reset callbacks
  public final List<Runnable> resetCallbacks = new CopyOnWriteArrayList<>();

  // capacity configs: service -> CapacityConfig
  private final Map<String, CapacityConfig> capacityConfigs =
      Collections.synchronizedMap(new LinkedHashMap<>());

  // fake servers: name -> endpoint URL
  private final Map<String, String> fakeServers =
      Collections.synchronizedMap(new LinkedHashMap<>());

  // injected states: "service:resourceType:resourceId" -> state string
  private final Map<String, String> injectedStates =
      Collections.synchronizedMap(new LinkedHashMap<>());

  // lifecycle rules: service -> LifecycleRule
  private final Map<String, LifecycleRule> lifecycleRules =
      Collections.synchronizedMap(new LinkedHashMap<>());

  /**
   * Per-service capacity configuration. {@code slots=null} means unlimited; {@code slots=0} means
   * exhausted.
   */
  public static class CapacityConfig {
    private Integer slots;

    public Integer getSlots() {
      return slots;
    }

    public void setSlots(Integer slots) {
      this.slots = slots;
    }

    public boolean isExhausted() {
      return slots != null && slots == 0;
    }

    public void reset() {
      this.slots = null;
    }
  }

  /** Per-service lifecycle dwell configuration. */
  public static class LifecycleRule {
    private boolean enabled;
    private int createDwellMs;
    private int deleteDwellMs;

    public boolean isEnabled() {
      return enabled;
    }

    public void setEnabled(boolean enabled) {
      this.enabled = enabled;
    }

    public int getCreateDwellMs() {
      return createDwellMs;
    }

    public void setCreateDwellMs(int createDwellMs) {
      this.createDwellMs = createDwellMs;
    }

    public int getDeleteDwellMs() {
      return deleteDwellMs;
    }

    public void setDeleteDwellMs(int deleteDwellMs) {
      this.deleteDwellMs = deleteDwellMs;
    }
  }

  /** Returns the {@link CapacityConfig} for the given service, creating one if absent. */
  public CapacityConfig getCapacityConfig(String service) {
    return capacityConfigs.computeIfAbsent(service, k -> new CapacityConfig());
  }

  /** Resets capacity for all services to unlimited. */
  public void resetAllCapacity() {
    capacityConfigs.values().forEach(CapacityConfig::reset);
  }

  public void registerFakeServer(String name, String endpoint) {
    fakeServers.put(name, endpoint);
  }

  public Optional<String> getFakeServer(String name) {
    return Optional.ofNullable(fakeServers.get(name));
  }

  public Map<String, String> listFakeServers() {
    return Collections.unmodifiableMap(fakeServers);
  }

  public void setInjectedState(
      String service, String resourceType, String resourceId, String stateValue) {
    injectedStates.put(service + ":" + resourceType + ":" + resourceId, stateValue);
  }

  public void clearInjectedState(String service, String resourceType, String resourceId) {
    injectedStates.remove(service + ":" + resourceType + ":" + resourceId);
  }

  public Optional<String> getInjectedState(String service, String resourceType, String resourceId) {
    return Optional.ofNullable(injectedStates.get(service + ":" + resourceType + ":" + resourceId));
  }

  public LifecycleRule getLifecycleRule(String service) {
    return lifecycleRules.getOrDefault(service, new LifecycleRule());
  }

  public void setLifecycleRule(String service, LifecycleRule rule) {
    lifecycleRules.put(service, rule);
  }

  public Map<String, LifecycleRule> getAllLifecycleRules() {
    return Collections.unmodifiableMap(lifecycleRules);
  }

  public void reset() {
    chaosRules.clear();
    fakeRules.clear();
    iamEnforce = false;
    iamDefaultIdentity = null;
    iamIdentities.clear();
    iamResourcePolicies.clear();
    logBuffer.clear();
    resetAllCapacity();
    fakeServers.clear();
    injectedStates.clear();
    lifecycleRules.clear();
    for (Runnable cb : resetCallbacks) {
      try {
        cb.run();
      } catch (Exception ignored) { // reset callback failure; swallowed
      }
    }
  }

  public void addLog(Map<String, Object> entry) {
    logBuffer.add(entry);
    if (logBuffer.size() > 500) {
      ((CopyOnWriteArrayList<Map<String, Object>>) logBuffer).remove(0);
    }
  }

  /** Returns an unmodifiable snapshot of all capacity configs keyed by service name. */
  public Map<String, CapacityConfig> getAllCapacityConfigs() {
    return Collections.unmodifiableMap(capacityConfigs);
  }
}
