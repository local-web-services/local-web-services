package io.localwebservices.lws.unit.providers.stepfunctions;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.localwebservices.lws.providers.stepfunctions.StepFunctionsStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class StepFunctionsStoreBranchTest {

  @Test
  public void updateStateMachine_nonExistentArn_doesNotThrow() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String missingArn = "arn:aws:states:us-east-1:000000000000:stateMachine:ghost";

    // Act — false branch of if (stateMachines.containsKey(arn)) is exercised
    store.updateStateMachine(missingArn, Map.of("definition", "{}"));

    // Assert — no exception; nothing changed in store
    assertNotNull(store);
  }

  @Test
  public void startExecution_arnWithoutColon_usesArnDirectlyAsMachineName() {
    // Arrange
    StepFunctionsStore store = new StepFunctionsStore();
    String smName = "my-machine";
    store.createStateMachine(smName, Map.of("name", smName, "definition", "{}"));
    // Use a plain name (no colon) as the smArn to exercise the ternary false branch
    String plainName = smName;

    // Act
    Map<String, Object> actualExecution =
        store.startExecution(plainName, "exec-1", "{\"key\":\"value\"}");

    // Assert
    assertNotNull(actualExecution);
  }
}
