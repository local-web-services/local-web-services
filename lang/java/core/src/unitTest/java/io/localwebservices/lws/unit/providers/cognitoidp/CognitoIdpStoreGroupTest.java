package io.localwebservices.lws.unit.providers.cognitoidp;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.cognitoidp.CognitoIdpStore;
import java.util.Collections;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import org.junit.jupiter.api.Test;

public class CognitoIdpStoreGroupTest {

  @Test
  public void groups_put_storesGroup() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedPoolId = "pool1";
    String expectedGroupName = "admins";

    // Act
    store
        .groups
        .computeIfAbsent(expectedPoolId, k -> new ConcurrentHashMap<>())
        .put(expectedGroupName, Map.of("GroupName", expectedGroupName));

    // Assert
    Map<String, Object> actualGroup = store.groups.get(expectedPoolId).get(expectedGroupName);
    assertNotNull(actualGroup, "Expected actualGroup to not be null");
  }

  @Test
  public void groupMembers_add_storesMembership() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedPoolId = "pool1";
    String expectedGroupName = "admins";
    String expectedUsername = "alice";

    // Act
    store
        .groupMembers
        .computeIfAbsent(expectedPoolId, k -> new ConcurrentHashMap<>())
        .computeIfAbsent(
            expectedGroupName, k -> Collections.newSetFromMap(new ConcurrentHashMap<>()))
        .add(expectedUsername);

    // Assert
    Set<String> actualMembers = store.groupMembers.get(expectedPoolId).get(expectedGroupName);
    assertTrue(
        actualMembers.contains(expectedUsername), "Expected value to contain expected substring");
  }

  @Test
  public void reset_clearsGroups() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    store
        .groups
        .computeIfAbsent("pool1", k -> new ConcurrentHashMap<>())
        .put("admins", Map.of("GroupName", "admins"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.groups.isEmpty(), "Expected store.groups to be empty");
  }

  @Test
  public void reset_clearsGroupMembers() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    store
        .groupMembers
        .computeIfAbsent("pool1", k -> new ConcurrentHashMap<>())
        .computeIfAbsent("admins", k -> Collections.newSetFromMap(new ConcurrentHashMap<>()))
        .add("alice");

    // Act
    store.reset();

    // Assert
    assertTrue(store.groupMembers.isEmpty(), "Expected store.groupMembers to be empty");
  }
}
