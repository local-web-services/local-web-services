package io.localwebservices.lws;

import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;

/** Shared mutable server state. */
public class ServerState {

    // chaos rules: service -> operation -> config map
    public final Map<String, Map<String, Map<String, Object>>> chaosRules = Collections.synchronizedMap(new LinkedHashMap<>());

    // fake response rules: service -> config (enabled, rules list)
    public final Map<String, Map<String, Object>> fakeRules = Collections.synchronizedMap(new LinkedHashMap<>());

    // IAM config
    public volatile boolean iamEnforce = false;
    public volatile String iamDefaultIdentity = null;
    public final Map<String, Object> iamIdentities = Collections.synchronizedMap(new LinkedHashMap<>());
    public final Map<String, Object> iamResourcePolicies = Collections.synchronizedMap(new LinkedHashMap<>());

    // log buffer (max 500 entries)
    public final List<Map<String, Object>> logBuffer = new CopyOnWriteArrayList<>();

    // Reset callbacks
    public final List<Runnable> resetCallbacks = new CopyOnWriteArrayList<>();

    public void reset() {
        chaosRules.clear();
        fakeRules.clear();
        iamEnforce = false;
        iamDefaultIdentity = null;
        iamIdentities.clear();
        iamResourcePolicies.clear();
        logBuffer.clear();
        for (Runnable cb : resetCallbacks) {
            try { cb.run(); } catch (Exception ignored) {}
        }
    }

    public void addLog(Map<String, Object> entry) {
        logBuffer.add(entry);
        if (logBuffer.size() > 500) {
            ((CopyOnWriteArrayList<Map<String, Object>>) logBuffer).remove(0);
        }
    }
}
