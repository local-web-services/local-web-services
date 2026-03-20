package io.localwebservices.lws.unit.providers.cognitoidp;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.cognitoidp.CognitoIdpStore;
import java.util.Map;
import java.util.Set;
import org.junit.jupiter.api.Test;

public class CognitoIdpStoreTest {

  @Test
  public void reset_clearsAllMaps() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedPoolId = "pool-abc";
    store.pools.put(expectedPoolId, Map.of("UserPoolId", expectedPoolId));
    store.users.put(expectedPoolId, Map.of("alice", Map.of("Username", "alice")));
    store.groups.put(expectedPoolId, Map.of("admins", Map.of("GroupName", "admins")));
    store.groupMembers.put(expectedPoolId, Map.of("admins", Set.of("alice")));
    store.clients.put("client-1", Map.of("ClientId", "client-1"));
    store.authSessions.put("session-1", Map.of("Session", "session-1"));

    // Act
    store.reset();

    // Assert
    assertFalse(store.pools.containsKey(expectedPoolId), "Expected map to not contain the key");
    assertFalse(store.users.containsKey(expectedPoolId), "Expected map to not contain the key");
    assertFalse(store.groups.containsKey(expectedPoolId), "Expected map to not contain the key");
    assertFalse(store.groupMembers.containsKey(expectedPoolId), "Expected map to not contain the key");
    assertFalse(store.clients.containsKey("client-1"), "Expected map to not contain the key");
    assertFalse(store.authSessions.containsKey("session-1"), "Expected map to not contain the key");
  }

  @Test
  public void pools_storeAndRetrieveByKey() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedPoolId = "test-pool-id";

    // Act
    store.pools.put(expectedPoolId, Map.of("UserPoolId", expectedPoolId));

    // Assert
    assertTrue(store.pools.containsKey(expectedPoolId), "Expected map to contain the expected key");
  }

  @Test
  public void clients_storeAndRetrieveByKey() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedClientId = "test-client-id";

    // Act
    store.clients.put(expectedClientId, Map.of("ClientId", expectedClientId));

    // Assert
    assertTrue(store.clients.containsKey(expectedClientId), "Expected map to contain the expected key");
  }
}
