package io.localwebservices.lws.unit.state;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.ServerState;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import org.junit.jupiter.api.Test;

public class ServerStateTest {

  @Test
  public void reset_clearsChaosRules() {
    // Arrange
    ServerState state = new ServerState();
    state.chaosRules.put("dynamodb", Map.of("PutItem", Map.of("error", "500")));

    // Act
    state.reset();

    // Assert
    assertTrue(state.chaosRules.isEmpty(), "Expected state.chaosRules to be empty");
  }

  @Test
  public void reset_clearsFakeRules() {
    // Arrange
    ServerState state = new ServerState();
    state.fakeRules.put("s3", Map.of("enabled", true));

    // Act
    state.reset();

    // Assert
    assertTrue(state.fakeRules.isEmpty(), "Expected state.fakeRules to be empty");
  }

  @Test
  public void reset_clearsIamIdentities() {
    // Arrange
    ServerState state = new ServerState();
    state.iamIdentities.put("user1", Map.of("role", "read"));

    // Act
    state.reset();

    // Assert
    assertTrue(state.iamIdentities.isEmpty(), "Expected state.iamIdentities to be empty");
  }

  @Test
  public void reset_resetsIamEnforce() {
    // Arrange
    ServerState state = new ServerState();
    state.iamEnforce = true;

    // Act
    state.reset();

    // Assert
    assertFalse(state.iamEnforce, "Expected condition to be false: state.iamEnforce");
  }

  @Test
  public void reset_invokesCallbacks() {
    // Arrange
    ServerState state = new ServerState();
    AtomicBoolean expectedCallbackInvoked = new AtomicBoolean(false);
    state.resetCallbacks.add(() -> expectedCallbackInvoked.set(true));

    // Act
    state.reset();

    // Assert
    boolean actualCallbackInvoked = expectedCallbackInvoked.get();
    assertTrue(actualCallbackInvoked, "Expected callback to have been invoked");
  }

  @Test
  public void addLog_addsToBuffer() {
    // Arrange
    ServerState state = new ServerState();
    int expectedSize = 1;

    // Act
    state.addLog(Map.of("msg", "test"));

    // Assert
    int actualSize = state.logBuffer.size();
    assertEquals(expectedSize, actualSize, "Expected actualSize to match expectedSize");
  }

  @Test
  public void addLog_capsAt500() {
    // Arrange
    ServerState state = new ServerState();
    int expectedMaxSize = 500;
    for (int i = 0; i < 501; i++) {
      state.addLog(Map.of("i", i));
    }

    // Act
    int actualSize = state.logBuffer.size();

    // Assert
    assertTrue(actualSize <= expectedMaxSize, "Expected condition to be true: actualSize <= expectedMaxSize");
  }
}
