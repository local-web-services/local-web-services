package io.localwebservices.lws.providers.stepfunctions;

import java.time.Instant;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory Step Functions storage. */
public class StepFunctionsStore {

  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final Map<String, Map<String, Object>> stateMachines = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> executions = new ConcurrentHashMap<>();
  private final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

  public void reset() {
    stateMachines.clear();
    executions.clear();
    resourceTags.clear();
  }

  public String stateMachineArn(String name) {
    return "arn:aws:states:" + REGION + ":" + ACCOUNT + ":stateMachine:" + name;
  }

  public boolean stateMachineExists(String arn) {
    return stateMachines.containsKey(arn);
  }

  public Map<String, Object> createStateMachine(String name, Map<String, Object> body) {
    String arn = stateMachineArn(name);
    Map<String, Object> sm = new LinkedHashMap<>(body);
    sm.put("stateMachineArn", arn);
    sm.put("creationDate", Instant.now().getEpochSecond() * 1.0);
    sm.put("status", "ACTIVE");
    stateMachines.put(arn, sm);
    return sm;
  }

  public Map<String, Object> getStateMachine(String arn) {
    return stateMachines.get(arn);
  }

  public void deleteStateMachine(String arn) {
    stateMachines.remove(arn);
  }

  public void updateStateMachine(String arn, Map<String, Object> body) {
    if (stateMachines.containsKey(arn)) {
      stateMachines.get(arn).putAll(body);
    }
  }

  public List<Map<String, Object>> listStateMachines() {
    List<Map<String, Object>> list = new ArrayList<>();
    for (Map<String, Object> sm : stateMachines.values()) {
      list.add(
          Map.of(
              "stateMachineArn",
              sm.get("stateMachineArn"),
              "name",
              sm.get("name"),
              "creationDate",
              sm.get("creationDate"),
              "type",
              sm.getOrDefault("type", "STANDARD")));
    }
    return list;
  }

  public Map<String, Object> startExecution(String smArn, String execName, String input) {
    return startExecutionWithOutput(smArn, execName, input, input);
  }

  /**
   * Records a new execution with an explicit output (used when the execution engine has computed
   * the real output via service task bridges).
   */
  public Map<String, Object> startExecutionWithOutput(
      String smArn, String execName, String input, String output) {
    String machineName = smArn.contains(":") ? smArn.substring(smArn.lastIndexOf(':') + 1) : smArn;
    String execArn =
        "arn:aws:states:" + REGION + ":" + ACCOUNT + ":execution:" + machineName + ":" + execName;
    double startDate = Instant.now().getEpochSecond() * 1.0;
    Map<String, Object> exec = new LinkedHashMap<>();
    exec.put("executionArn", execArn);
    exec.put("stateMachineArn", smArn);
    exec.put("name", execName);
    exec.put("status", "SUCCEEDED");
    exec.put("startDate", startDate);
    exec.put("stopDate", startDate);
    exec.put("input", input);
    exec.put("output", output != null ? output : input);
    executions.put(execArn, exec);
    return exec;
  }

  public boolean executionExists(String execArn) {
    return executions.containsKey(execArn);
  }

  public Map<String, Object> getExecution(String execArn) {
    return executions.get(execArn);
  }

  public void stopExecution(String execArn, double stopDate) {
    executions.get(execArn).put("status", "ABORTED");
    executions.get(execArn).put("stopDate", stopDate);
  }

  public List<Map<String, Object>> listExecutions(String smArn) {
    List<Map<String, Object>> list = new ArrayList<>();
    for (Map<String, Object> exec : executions.values()) {
      if (smArn.equals(exec.get("stateMachineArn"))) {
        list.add(
            Map.of(
                "executionArn",
                exec.get("executionArn"),
                "stateMachineArn",
                exec.get("stateMachineArn"),
                "name",
                exec.get("name"),
                "status",
                exec.get("status"),
                "startDate",
                exec.get("startDate")));
      }
    }
    return list;
  }

  public List<Map<String, String>> listTags(String resourceArn) {
    return resourceTags.getOrDefault(resourceArn, List.of());
  }

  @SuppressWarnings("unchecked")
  public void tagResource(String resourceArn, List<Map<String, Object>> newTags) {
    List<Map<String, String>> existing =
        resourceTags.computeIfAbsent(resourceArn, k -> new ArrayList<>());
    for (Map<String, Object> tag : newTags) {
      existing.add(Map.of("key", (String) tag.get("key"), "value", (String) tag.get("value")));
    }
  }

  public boolean allTagsFound(String resourceArn, List<String> tagKeys) {
    List<Map<String, String>> existing = resourceTags.getOrDefault(resourceArn, new ArrayList<>());
    return tagKeys.stream().allMatch(k -> existing.stream().anyMatch(t -> k.equals(t.get("key"))));
  }

  public void untagResource(String resourceArn, List<String> tagKeys) {
    List<Map<String, String>> existing = resourceTags.getOrDefault(resourceArn, new ArrayList<>());
    existing.removeIf(t -> tagKeys.contains(t.get("key")));
  }
}
