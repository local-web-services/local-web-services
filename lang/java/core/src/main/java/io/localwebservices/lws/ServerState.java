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

  /** Returns the {@link CapacityConfig} for the given service, creating one if absent. */
  public CapacityConfig getCapacityConfig(String service) {
    return capacityConfigs.computeIfAbsent(service, k -> new CapacityConfig());
  }

  /** Resets capacity for all services to unlimited. */
  public void resetAllCapacity() {
    capacityConfigs.values().forEach(CapacityConfig::reset);
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
