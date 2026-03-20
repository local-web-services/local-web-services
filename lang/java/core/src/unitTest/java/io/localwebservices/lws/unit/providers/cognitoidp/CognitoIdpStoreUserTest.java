package io.localwebservices.lws.unit.providers.cognitoidp;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.cognitoidp.CognitoIdpStore;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.junit.jupiter.api.Test;

public class CognitoIdpStoreUserTest {

  @Test
  public void users_put_storesUserInPool() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedPoolId = "pool1";
    String expectedUsername = "alice";

    // Act
    store
        .users
        .computeIfAbsent(expectedPoolId, k -> new ConcurrentHashMap<>())
        .put(expectedUsername, Map.of("Username", expectedUsername));

    // Assert
    Map<String, Object> actualUser = store.users.get(expectedPoolId).get(expectedUsername);
    assertNotNull(actualUser, "Expected actualUser to not be null");
  }

  @Test
  public void users_remove_deletesUser() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedPoolId = "pool1";
    String expectedUsername = "alice";
    store
        .users
        .computeIfAbsent(expectedPoolId, k -> new ConcurrentHashMap<>())
        .put(expectedUsername, Map.of("Username", expectedUsername));

    // Act
    store.users.get(expectedPoolId).remove(expectedUsername);

    // Assert
    Map<String, Object> actualUser = store.users.get(expectedPoolId).get(expectedUsername);
    assertNull(actualUser, "Expected actualUser to be null");
  }

  @Test
  public void reset_clearsUsers() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    store
        .users
        .computeIfAbsent("pool1", k -> new ConcurrentHashMap<>())
        .put("alice", Map.of("Username", "alice"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.users.isEmpty(), "Expected store.users to be empty");
  }
}
