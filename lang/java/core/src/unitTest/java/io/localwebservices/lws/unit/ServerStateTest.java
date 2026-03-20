package io.localwebservices.lws.unit;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.ServerState;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import org.junit.jupiter.api.Test;

public class ServerStateTest {

  @Test
  public void reset_clearsChaosAndFakeRulesAndIam() {
    // Arrange
    ServerState state = new ServerState();
    state.chaosRules.put("dynamodb", Map.of("PutItem", Map.of("error", "500")));
    state.fakeRules.put("s3", Map.of("enabled", true));
    state.iamEnforce = true;
    state.iamDefaultIdentity = "admin";
    state.iamIdentities.put("user1", Map.of("role", "read"));

    // Act
    state.reset();

    // Assert
    assertTrue(state.chaosRules.isEmpty(), "Expected state.chaosRules to be empty");
    assertTrue(state.fakeRules.isEmpty(), "Expected state.fakeRules to be empty");
    assertFalse(state.iamEnforce, "Expected condition to be false: state.iamEnforce");
    assertNull(state.iamDefaultIdentity, "Expected state.iamDefaultIdentity to be null");
    assertTrue(state.iamIdentities.isEmpty(), "Expected state.iamIdentities to be empty");
  }

  @Test
  public void reset_invokesRegisteredCallbacks() {
    // Arrange
    ServerState state = new ServerState();
    AtomicBoolean callbackInvoked = new AtomicBoolean(false);
    state.resetCallbacks.add(() -> callbackInvoked.set(true));

    // Act
    state.reset();

    // Assert
    assertTrue(callbackInvoked.get(), "Expected callback to have been invoked");
  }

  @Test
  public void reset_swallowsCallbackExceptions() {
    // Arrange
    ServerState state = new ServerState();
    state.resetCallbacks.add(
        () -> {
          throw new RuntimeException("callback failure");
        });
    state.chaosRules.put("sqs", Map.of());

    // Act — must not throw
    state.reset();

    // Assert
    assertTrue(state.chaosRules.isEmpty(), "Expected state.chaosRules to be empty");
  }

  @Test
  public void addLog_appendsEntry() {
    // Arrange
    ServerState state = new ServerState();
    Map<String, Object> expectedEntry = Map.of("service", "lambda", "op", "Invoke");

    // Act
    state.addLog(expectedEntry);

    // Assert
    assertEquals(1, state.logBuffer.size(), "Expected state.logBuffer.size() to match 1");
    assertEquals(expectedEntry, state.logBuffer.get(0), "Expected state.logBuffer.get(0) to equal expectedEntry");
  }

  @Test
  public void addLog_exceedingCapacity_removesOldestEntry() {
    // Arrange
    ServerState state = new ServerState();
    for (int i = 0; i < 500; i++) {
      state.addLog(Map.of("i", i));
    }
    Map<String, Object> expectedLastEntry = Map.of("service", "new-entry");

    // Act — adding one more entry beyond 500
    state.addLog(expectedLastEntry);

    // Assert
    assertEquals(500, state.logBuffer.size(), "Expected state.logBuffer.size() to match 500");
    assertEquals(expectedLastEntry, state.logBuffer.get(state.logBuffer.size() - 1), "Expected state.logBuffer.get(state.logBuffer.size() - 1) to match expectedLastEntry");
  }

  @Test
  public void chaosRules_storeAndRetrieve() {
    // Arrange
    ServerState state = new ServerState();
    String expectedService = "dynamodb";
    String expectedOp = "GetItem";

    // Act
    state.chaosRules.put(expectedService, Map.of(expectedOp, Map.of("latency", "200")));

    // Assert
    assertTrue(state.chaosRules.containsKey(expectedService), "Expected map to contain the expected key");
    assertTrue(state.chaosRules.get(expectedService).containsKey(expectedOp), "Expected map to contain the expected key");
  }

  @Test
  public void iamResourcePolicies_storeAndRetrieve() {
    // Arrange
    ServerState state = new ServerState();
    String expectedArn = "arn:aws:s3:::my-bucket";

    // Act
    state.iamResourcePolicies.put(expectedArn, Map.of("Version", "2012-10-17"));

    // Assert
    assertTrue(state.iamResourcePolicies.containsKey(expectedArn), "Expected map to contain the expected key");
  }

  @Test
  public void logBuffer_initiallyEmpty() {
    // Arrange
    ServerState state = new ServerState();
    int expectedSize = 0;

    // Act
    List<Map<String, Object>> actualBuffer = state.logBuffer;

    // Assert
    assertEquals(expectedSize, actualBuffer.size(), "Expected actualBuffer.size() to match expectedSize");
  }
}
