package io.localwebservices.lws.unit.providers.stepfunctions;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.stepfunctions.StepFunctionsStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class StepFunctionsStoreExecutionTest {

  @Test
  public void startExecution_newExecution_storesAndReturnsExecMap() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));

    // Act
    Map<String, Object> actualExec = store.startExecution(smArn, "exec-1", "{}");
    String actualExecArn = (String) actualExec.get("executionArn");

    // Assert
    assertNotNull(actualExec);
    assertTrue(store.executionExists(actualExecArn));
  }

  @Test
  public void startExecution_setsStatusSucceeded() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    String expectedStatus = "SUCCEEDED";

    // Act
    Map<String, Object> actualExec = store.startExecution(smArn, "exec-1", "{}");

    // Assert
    assertEquals(expectedStatus, actualExec.get("status"));
  }

  @Test
  public void startExecution_copiesInputToOutput() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    String expectedInput = "myinput";

    // Act
    Map<String, Object> actualExec = store.startExecution(smArn, "exec-1", expectedInput);

    // Assert
    assertEquals(expectedInput, actualExec.get("input"));
    assertEquals(expectedInput, actualExec.get("output"));
  }

  @Test
  public void executionExists_nonExistent_returnsFalse() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String unknownExecArn = "arn:aws:states:us-east-1:000000000000:execution:my-sm:unknown";

    // Act
    boolean actualResult = store.executionExists(unknownExecArn);

    // Assert
    assertFalse(actualResult);
  }

  @Test
  public void getExecution_existingExec_returnsMap() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    Map<String, Object> started = store.startExecution(smArn, "exec-1", "{}");
    String expectedExecArn = (String) started.get("executionArn");

    // Act
    Map<String, Object> actualExec = store.getExecution(expectedExecArn);

    // Assert
    assertNotNull(actualExec);
    assertEquals(expectedExecArn, actualExec.get("executionArn"));
  }

  @Test
  public void stopExecution_changesStatusToAborted() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    Map<String, Object> started = store.startExecution(smArn, "exec-1", "{}");
    String execArn = (String) started.get("executionArn");
    String expectedStatus = "ABORTED";

    // Act
    store.stopExecution(execArn, System.currentTimeMillis() / 1000.0);

    // Assert
    Map<String, Object> actualExec = store.getExecution(execArn);
    assertEquals(expectedStatus, actualExec.get("status"));
  }

  @Test
  public void listExecutions_filtersByStateMachineArn() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineNameA = "sm-alpha";
    String machineNameB = "sm-beta";
    String smArnA = store.stateMachineArn(machineNameA);
    String smArnB = store.stateMachineArn(machineNameB);
    store.createStateMachine(machineNameA, Map.of("name", machineNameA));
    store.createStateMachine(machineNameB, Map.of("name", machineNameB));
    store.startExecution(smArnA, "exec-a1", "{}");
    store.startExecution(smArnA, "exec-a2", "{}");
    store.startExecution(smArnB, "exec-b1", "{}");
    int expectedSizeA = 2;
    int expectedSizeB = 1;

    // Act
    List<Map<String, Object>> actualExecsA = store.listExecutions(smArnA);
    List<Map<String, Object>> actualExecsB = store.listExecutions(smArnB);

    // Assert
    assertEquals(expectedSizeA, actualExecsA.size());
    assertEquals(expectedSizeB, actualExecsB.size());
  }
}
