package io.localwebservices.lws.providers.stepfunctions;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Executes a Step Functions state machine definition synchronously by walking its states. Used by
 * StartExecution and StartSyncExecution operations.
 */
class StepFunctionsSyncExecutor {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final StepFunctionsStore store;
  private final StepFunctionsServiceTaskOps serviceTaskOps;

  StepFunctionsSyncExecutor(StepFunctionsStore store, StepFunctionsServiceTaskOps serviceTaskOps) {
    this.store = store;
    this.serviceTaskOps = serviceTaskOps;
  }

  /**
   * Executes a state machine synchronously by walking its states. Returns the final output as a
   * JSON string, or the original input if execution cannot be performed.
   */
  @SuppressWarnings("unchecked")
  String execute(String smArn, String input) {
    Map<String, Object> sm = store.getStateMachine(smArn);
    if (sm == null) {
      return input;
    }
    String definitionStr = (String) sm.get("definition");
    if (definitionStr == null) {
      return input;
    }
    Map<String, Object> definition;
    try {
      definition = MAPPER.readValue(definitionStr, Map.class);
    } catch (Exception e) {
      return input;
    }
    Map<String, Object> states = (Map<String, Object>) definition.get("States");
    if (states == null) {
      return input;
    }
    String startAt = (String) definition.get("StartAt");
    if (startAt == null) {
      return input;
    }

    Map<String, Object> currentData;
    try {
      currentData =
          input != null && !input.isEmpty()
              ? MAPPER.readValue(input, Map.class)
              : new LinkedHashMap<>();
    } catch (Exception e) {
      currentData = new LinkedHashMap<>();
    }

    String currentStateName = startAt;
    int maxSteps = 100;
    int steps = 0;
    while (currentStateName != null && steps < maxSteps) {
      steps++;
      Map<String, Object> stateDefObj = (Map<String, Object>) states.get(currentStateName);
      if (stateDefObj == null) {
        break;
      }
      String stateType = (String) stateDefObj.get("Type");
      if ("Task".equals(stateType)) {
        String resource = (String) stateDefObj.get("Resource");
        Map<String, Object> taskParams =
            stateDefObj.containsKey("Parameters")
                ? (Map<String, Object>) stateDefObj.get("Parameters")
                : currentData;
        Map<String, Object> taskOutput = serviceTaskOps.executeServiceTask(resource, taskParams);
        if (taskOutput != null) {
          currentData = taskOutput;
        }
      } else if ("Pass".equals(stateType)) {
        if (stateDefObj.containsKey("Result")) {
          currentData = (Map<String, Object>) stateDefObj.get("Result");
        }
      }
      Boolean end = (Boolean) stateDefObj.get("End");
      if (Boolean.TRUE.equals(end)) {
        break;
      }
      currentStateName = (String) stateDefObj.get("Next");
    }

    try {
      return MAPPER.writeValueAsString(currentData);
    } catch (Exception e) {
      return input;
    }
  }
}
