package io.localwebservices.lws.unit.providers.cognitoidp;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.cognitoidp.CognitoIdpStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class CognitoIdpStoreClientTest {

  @Test
  public void clients_put_storesClient() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedClientId = "clientId1";

    // Act
    store.clients.put(
        expectedClientId, Map.of("ClientId", expectedClientId, "UserPoolId", "pool1"));

    // Assert
    Map<String, Object> actualClient = store.clients.get(expectedClientId);
    assertNotNull(actualClient);
  }

  @Test
  public void clients_remove_deletesClient() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    String expectedClientId = "clientId1";
    store.clients.put(
        expectedClientId, Map.of("ClientId", expectedClientId, "UserPoolId", "pool1"));

    // Act
    store.clients.remove(expectedClientId);

    // Assert
    Map<String, Object> actualClient = store.clients.get(expectedClientId);
    assertNull(actualClient);
  }

  @Test
  public void reset_clearsClients() {
    // Arrange
    CognitoIdpStore store = new CognitoIdpStore();
    store.clients.put("clientId1", Map.of("ClientId", "clientId1", "UserPoolId", "pool1"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.clients.isEmpty());
  }
}
