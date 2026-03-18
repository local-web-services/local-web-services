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
  public void putSecretValue_updatesValueAndVersionId() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "rotate-secret";
    Map<String, Object> secret = store.createSecret(secretName, "original-value", null, null);
    String originalVersionId = (String) secret.get("VersionId");
    String expectedSecretString = "rotated-value";

    // Act
    store.putSecretValue(secret, expectedSecretString, null);

    // Assert
    assertEquals(expectedSecretString, secret.get("SecretString"));
    assertNotEquals(originalVersionId, secret.get("VersionId"));
  }

  @Test
  public void updateSecret_updatesSecretString() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "update-secret";
    Map<String, Object> secret = store.createSecret(secretName, "old-value", null, null);
    String expectedSecretString = "new-value";
    String expectedVersionId = "fixed-version-id";

    // Act
    store.updateSecret(secret, expectedSecretString, null, expectedVersionId);

    // Assert
    assertEquals(expectedSecretString, secret.get("SecretString"));
    assertEquals(expectedVersionId, secret.get("VersionId"));
  }

  @Test
  public void deleteSecret_softDelete_setsDeletedDate() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "soft-delete-secret";
    store.createSecret(secretName, "value", null, null);

    // Act
    store.deleteSecret(secretName, false);

    // Assert
    Map<String, Object> actualSecret = store.findSecret(secretName);
    assertNotNull(actualSecret);
    assertNotNull(actualSecret.get("DeletedDate"));
  }

  @Test
  public void deleteSecret_forceDelete_removesSecret() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "force-delete-secret";
    store.createSecret(secretName, "value", null, null);

    // Act
    store.deleteSecret(secretName, true);

    // Assert
    Map<String, Object> actualSecret = store.findSecret(secretName);
    assertNull(actualSecret);
  }

  @Test
  public void restoreSecret_softDeletedSecret_removesDeletedDate() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "restore-secret";
    Map<String, Object> secret = store.createSecret(secretName, "value", null, null);
    store.deleteSecret(secretName, false);

    // Act
    store.restoreSecret(secret);

    // Assert
    assertNull(secret.get("DeletedDate"));
  }

  @Test
  public void listSecrets_includesDeletedDate_whenDeleted() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "listed-deleted-secret";
    store.createSecret(secretName, "value", null, null);
    store.deleteSecret(secretName, false);

    // Act
    List<Map<String, Object>> actualSecrets = store.listSecrets();

    // Assert
    assertTrue(actualSecrets.stream().anyMatch(e -> e.containsKey("DeletedDate")));
  }
}
