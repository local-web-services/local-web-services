package io.localwebservices.lws.unit.providers.stepfunctions;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.stepfunctions.StepFunctionsStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class StepFunctionsStoreStateMachineTest {

  @Test
  public void createStateMachine_newName_storesWithArn() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String expectedArn = store.stateMachineArn(machineName);

    // Act
    store.createStateMachine(machineName, Map.of("name", machineName));

    // Assert
    assertTrue(store.stateMachineExists(expectedArn), "Expected condition to be true: store.stateMachineExists(expectedArn)");
  }

  @Test
  public void stateMachineArn_returnsExpectedFormat() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String expectedArn = "arn:aws:states:us-east-1:000000000000:stateMachine:my-sm";

    // Act
    String actualArn = store.stateMachineArn(machineName);

    // Assert
    assertEquals(expectedArn, actualArn, "Expected actualArn to equal expectedArn");
  }

  @Test
  public void stateMachineExists_nonExistent_returnsFalse() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String unknownArn = "arn:aws:states:us-east-1:000000000000:stateMachine:does-not-exist";

    // Act
    boolean actualResult = store.stateMachineExists(unknownArn);

    // Assert
    assertFalse(actualResult, "Expected condition to be false: actualResult");
  }

  @Test
  public void getStateMachine_existingArn_returnsMap() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String expectedName = machineName;
    String arn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));

    // Act
    Map<String, Object> actualMachine = store.getStateMachine(arn);

    // Assert
    assertNotNull(actualMachine, "Expected actualMachine to not be null");
    assertEquals(expectedName, actualMachine.get("name"), "Expected name to match");
  }

  @Test
  public void getStateMachine_unknownArn_returnsNull() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String unknownArn = "arn:aws:states:us-east-1:000000000000:stateMachine:unknown";

    // Act
    Map<String, Object> actualMachine = store.getStateMachine(unknownArn);

    // Assert
    assertNull(actualMachine, "Expected actualMachine to be null");
  }

  @Test
  public void deleteStateMachine_removes() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String arn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));

    // Act
    store.deleteStateMachine(arn);

    // Assert
    assertFalse(store.stateMachineExists(arn), "Expected condition to be false: store.stateMachineExists(arn)");
  }

  @Test
  public void updateStateMachine_existingArn_updatesMap() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String arn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    String expectedDefinition = "{\"Comment\":\"updated\"}";

    // Act
    store.updateStateMachine(arn, Map.of("definition", expectedDefinition));

    // Assert
    Map<String, Object> actualMachine = store.getStateMachine(arn);
    assertEquals(expectedDefinition, actualMachine.get("definition"), "Expected definition to match");
  }

  @Test
  public void listStateMachines_twoMachines_returnsBoth() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    store.createStateMachine("sm-one", Map.of("name", "sm-one"));
    store.createStateMachine("sm-two", Map.of("name", "sm-two"));
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualList = store.listStateMachines();

    // Assert
    assertEquals(expectedSize, actualList.size(), "Expected actualList.size() to match expectedSize");
  }

  @Test
  public void reset_clearsAll() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String arn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));

    // Act
    store.reset();

    // Assert
    assertFalse(store.stateMachineExists(arn), "Expected condition to be false: store.stateMachineExists(arn)");
  }
}
