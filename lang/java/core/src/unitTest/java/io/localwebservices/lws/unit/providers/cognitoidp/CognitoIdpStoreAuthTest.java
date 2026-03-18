package io.localwebservices.lws.unit.providers.cognitoidp;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.cognitoidp.CognitoIdpStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class CognitoIdpStoreAuthTest {

  @Test
  public void authSessions_put_storesSession() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedSessionId = "session1";

    // Act
    store.authSessions.put(
        expectedSessionId, Map.of("Username", "alice", "ChallengeName", "NEW_PASSWORD_REQUIRED"));

    // Assert
    Map<String, Object> actualSession = store.authSessions.get(expectedSessionId);
    assertNotNull(actualSession);
  }

  @Test
  public void authSessions_remove_deletesSession() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedSessionId = "session1";
    store.authSessions.put(
        expectedSessionId, Map.of("Username", "alice", "ChallengeName", "NEW_PASSWORD_REQUIRED"));

    // Act
    store.authSessions.remove(expectedSessionId);

    // Assert
    Map<String, Object> actualSession = store.authSessions.get(expectedSessionId);
    assertNull(actualSession);
  }

  @Test
  public void reset_clearsAuthSessions() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    store.authSessions.put(
        "session1", Map.of("Username", "alice", "ChallengeName", "NEW_PASSWORD_REQUIRED"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.authSessions.isEmpty());
  }
}
