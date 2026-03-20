package io.localwebservices.lws.unit.providers.secretsmanager;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.secretsmanager.SecretsManagerStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SecretsManagerStorePutRotateTest {

  @Test
  public void putSecretValue_updatesVersionId() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    Map<String, Object> secret = store.createSecret(secretName, "original", null, null);
    String originalVersionId = (String) secret.get("VersionId");

    // Act
    store.putSecretValue(secret, "newVal", null);

    // Assert
    String actualVersionId = (String) secret.get("VersionId");
    assertNotEquals(originalVersionId, actualVersionId, "Expected originalVersionId and actualVersionId to differ");
  }

  @Test
  public void updateSecret_updatesSecretString() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    Map<String, Object> secret = store.createSecret(secretName, "original", null, null);
    String expectedSecretString = "updated";

    // Act
    store.updateSecret(secret, expectedSecretString, null, "newVer");

    // Assert
    assertEquals(expectedSecretString, secret.get("SecretString"), "Expected secretString to match");
  }

  @Test
  public void deleteSecret_softDelete_setsDeletedDate() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    store.createSecret(secretName, "value", null, null);

    // Act
    store.deleteSecret(secretName, false);

    // Assert
    Map<String, Object> actualSecret = store.findSecret(secretName);
    assertNotNull(actualSecret.get("DeletedDate"), "Expected values to match");
  }

  @Test
  public void deleteSecret_forceDelete_removesSecret() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    store.createSecret(secretName, "value", null, null);

    // Act
    store.deleteSecret(secretName, true);

    // Assert
    assertNull(store.findSecret(secretName), "Expected store.findSecret(secretName) to be null");
  }

  @Test
  public void restoreSecret_softDeletedSecret_removesDeletedDate() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    Map<String, Object> secret = store.createSecret(secretName, "value", null, null);
    store.deleteSecret(secretName, false);

    // Act
    store.restoreSecret(secret);

    // Assert
    assertNull(secret.get("DeletedDate"), "Expected values to match");
  }

  @Test
  public void listSecrets_deletedSecret_includesDeletedDate() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    store.createSecret(secretName, "value", null, null);
    store.deleteSecret(secretName, false);

    // Act
    List<Map<String, Object>> actualSecrets = store.listSecrets();

    // Assert
    assertTrue(actualSecrets.get(0).containsKey("DeletedDate"), "Expected map to contain the expected key");
  }
}
