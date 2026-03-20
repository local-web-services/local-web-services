package io.localwebservices.lws.unit.providers.stepfunctions;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.stepfunctions.StepFunctionsStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class StepFunctionsStoreHistoryTest {

  @Test
  public void listTags_noTags_returnsEmptyList() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    int expectedSize = 0;

    // Act
    List<Map<String, String>> actualTags = store.listTags(smArn);

    // Assert
    assertEquals(expectedSize, actualTags.size(), "Expected actualTags.size() to match expectedSize");
  }

  @Test
  public void tagResource_addsTags() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    List<Map<String, Object>> newTags =
        List.of(Map.of("key", "env", "value", "prod"), Map.of("key", "team", "value", "platform"));
    int expectedSize = 2;

    // Act
    store.tagResource(smArn, newTags);

    // Assert
    List<Map<String, String>> actualTags = store.listTags(smArn);
    assertEquals(expectedSize, actualTags.size(), "Expected actualTags.size() to match expectedSize");
  }

  @Test
  public void untagResource_removesSpecifiedKeys() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    store.tagResource(
        smArn,
        List.of(Map.of("key", "env", "value", "prod"), Map.of("key", "team", "value", "platform")));
    int expectedSize = 1;
    String expectedRemainingKey = "team";

    // Act
    store.untagResource(smArn, List.of("env"));

    // Assert
    List<Map<String, String>> actualTags = store.listTags(smArn);
    assertEquals(expectedSize, actualTags.size(), "Expected actualTags.size() to match expectedSize");
    assertEquals(expectedRemainingKey, actualTags.get(0).get("key"), "Expected remainingKey to match");
  }

  @Test
  public void allTagsFound_presentKeys_returnsTrue() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    store.tagResource(
        smArn,
        List.of(Map.of("key", "env", "value", "prod"), Map.of("key", "team", "value", "platform")));

    // Act
    boolean actualResult = store.allTagsFound(smArn, List.of("env", "team"));

    // Assert
    assertTrue(actualResult, "Expected condition to be true: actualResult");
  }

  @Test
  public void allTagsFound_missingKey_returnsFalse() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String machineName = "my-sm";
    String smArn = store.stateMachineArn(machineName);
    store.createStateMachine(machineName, Map.of("name", machineName));
    store.tagResource(smArn, List.of(Map.of("key", "env", "value", "prod")));

    // Act
    boolean actualResult = store.allTagsFound(smArn, List.of("env", "missing-key"));

    // Assert
    assertFalse(actualResult, "Expected condition to be false: actualResult");
  }
}
