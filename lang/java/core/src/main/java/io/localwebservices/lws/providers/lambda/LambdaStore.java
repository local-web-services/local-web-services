package io.localwebservices.lws.providers.lambda;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory Lambda state storage. */
public class LambdaStore {

  public final Map<String, Map<String, Object>> functions = new ConcurrentHashMap<>();
  public final Map<String, List<Map<String, Object>>> permissions = new ConcurrentHashMap<>();
  public final Map<String, Map<String, Object>> eventSourceMappings = new ConcurrentHashMap<>();

  public void reset() {
    functions.clear();
    permissions.clear();
    eventSourceMappings.clear();
  }
}
