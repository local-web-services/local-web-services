package io.localwebservices.lws.providers.ssm;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory SSM parameter storage. */
public class SsmStore {

  private final Map<String, Map<String, Object>> parameters = new ConcurrentHashMap<>();
  private final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

  public void reset() {
    parameters.clear();
    resourceTags.clear();
  }

  public boolean containsParameter(String name) {
    return parameters.containsKey(name);
  }

  public Map<String, Object> putParameter(
      String name, String value, String type, boolean overwrite) {
    Map<String, Object> param = new LinkedHashMap<>();
    param.put("Name", name);
    param.put("Value", value);
    param.put("Type", type != null ? type : "String");
    int version = 1;
    if (overwrite && parameters.containsKey(name)) {
      Object existingVersion = parameters.get(name).get("Version");
      if (existingVersion instanceof Number) {
        version = ((Number) existingVersion).intValue() + 1;
      }
    }
    param.put("Version", version);
    param.put("LastModifiedDate", System.currentTimeMillis() / 1000.0);
    parameters.put(name, param);
    return param;
  }

  public Map<String, Object> getParameter(String name) {
    return parameters.get(name);
  }

  public List<Map<String, Object>> getParameters(List<String> names) {
    List<Map<String, Object>> found = new ArrayList<>();
    for (String name : names) {
      Map<String, Object> param = parameters.get(name);
      if (param != null) {
        found.add(
            Map.of(
                "Name",
                param.get("Name"),
                "Value",
                param.get("Value"),
                "Type",
                param.get("Type"),
                "Version",
                param.get("Version")));
      }
    }
    return found;
  }

  public List<String> getInvalidParameters(List<String> names) {
    List<String> invalid = new ArrayList<>();
    for (String name : names) {
      if (!parameters.containsKey(name)) invalid.add(name);
    }
    return invalid;
  }

  public List<Map<String, Object>> getParametersByPath(String path) {
    List<Map<String, Object>> found = new ArrayList<>();
    for (Map.Entry<String, Map<String, Object>> entry : parameters.entrySet()) {
      if (entry.getKey().startsWith(path)) {
        Map<String, Object> param = entry.getValue();
        found.add(
            Map.of(
                "Name",
                param.get("Name"),
                "Value",
                param.get("Value"),
                "Type",
                param.get("Type"),
                "Version",
                param.get("Version")));
      }
    }
    return found;
  }

  public boolean deleteParameter(String name) {
    return parameters.remove(name) != null;
  }

  public List<String> deleteParameters(List<String> names) {
    List<String> deleted = new ArrayList<>();
    for (String name : names) {
      if (parameters.remove(name) != null) deleted.add(name);
    }
    return deleted;
  }

  public List<Map<String, Object>> describeParameters() {
    List<Map<String, Object>> params = new ArrayList<>();
    for (Map<String, Object> p : parameters.values()) {
      params.add(Map.of("Name", p.get("Name"), "Type", p.get("Type")));
    }
    return params;
  }

  @SuppressWarnings("unchecked")
  public void addTags(String resourceId, List<Map<String, Object>> newTags) {
    List<Map<String, String>> existing =
        resourceTags.computeIfAbsent(resourceId, k -> new ArrayList<>());
    for (Map<String, Object> tag : newTags) {
      existing.add(Map.of("Key", (String) tag.get("Key"), "Value", (String) tag.get("Value")));
    }
  }

  public void removeTags(String resourceId, List<String> tagKeys) {
    List<Map<String, String>> existing = resourceTags.getOrDefault(resourceId, new ArrayList<>());
    existing.removeIf(t -> tagKeys.contains(t.get("Key")));
  }

  public boolean hasTagAssociated(String resourceId, List<String> tagKeys) {
    List<Map<String, String>> existing = resourceTags.getOrDefault(resourceId, new ArrayList<>());
    return existing.stream().anyMatch(t -> tagKeys.contains(t.get("Key")));
  }

  public List<Map<String, String>> listTags(String resourceId) {
    return resourceTags.getOrDefault(resourceId, List.of());
  }
}
