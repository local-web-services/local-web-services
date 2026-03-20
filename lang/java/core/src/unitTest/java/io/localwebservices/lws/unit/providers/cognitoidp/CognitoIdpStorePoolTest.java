package io.localwebservices.lws.unit.providers.cognitoidp;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.cognitoidp.CognitoIdpStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class CognitoIdpStorePoolTest {

  @Test
  public void pools_put_storesPool() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedPoolId = "pool1";
    String expectedName = "MyPool";

    // Act
    store.pools.put(expectedPoolId, Map.of("Id", expectedPoolId, "Name", expectedName));

    // Assert
    String actualName = (String) store.pools.get(expectedPoolId).get("Name");
    assertEquals(expectedName, actualName, "Expected actualName to equal expectedName");
  }

  @Test
  public void pools_remove_deletesPool() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedPoolId = "pool1";
    store.pools.put(expectedPoolId, Map.of("Id", expectedPoolId, "Name", "MyPool"));

    // Act
    store.pools.remove(expectedPoolId);

    // Assert
    Map<String, Object> actualPool = store.pools.get(expectedPoolId);
    assertNull(actualPool, "Expected actualPool to be null");
  }

  @Test
  public void pools_size_returnsCount() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    int expectedCount = 2;
    store.pools.put("pool1", Map.of("Id", "pool1"));
    store.pools.put("pool2", Map.of("Id", "pool2"));

    // Act
    int actualCount = store.pools.size();

    // Assert
    assertEquals(expectedCount, actualCount, "Expected actualCount to match expectedCount");
  }

  @Test
  public void reset_clearsPools() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    store.pools.put("pool1", Map.of("Id", "pool1"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.pools.isEmpty(), "Expected store.pools to be empty");
  }
}
