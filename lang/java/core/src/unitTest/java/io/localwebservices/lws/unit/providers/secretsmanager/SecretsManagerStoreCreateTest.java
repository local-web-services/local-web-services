package io.localwebservices.lws.unit.providers.secretsmanager;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.secretsmanager.SecretsManagerStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SecretsManagerStoreCreateTest {

  @Test
  public void createSecret_newName_returnsSecretWithArn() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String expectedName = "my-secret";

    // Act
    Map<String, Object> actualSecret = store.createSecret(expectedName, "s3cr3t", null, null);

    // Assert
    assertEquals(expectedName, actualSecret.get("Name"));
    assertNotNull(actualSecret.get("ARN"));
    assertNotNull(actualSecret.get("VersionId"));
  }

  @Test
  public void secretArn_returnsExpectedFormat() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "arn-check-secret";
    String expectedAccount = "000000000000";
    String expectedRegion = "us-east-1";

    // Act
    String actualArn = store.secretArn(secretName);

    // Assert
    assertTrue(actualArn.contains(expectedAccount));
    assertTrue(actualArn.contains(expectedRegion));
    assertTrue(actualArn.contains(secretName));
  }

  @Test
  public void findSecret_byName_returnsSecret() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String expectedName = "find-by-name";
    store.createSecret(expectedName, "value", null, null);

    // Act
    Map<String, Object> actualSecret = store.findSecret(expectedName);

    // Assert
    assertNotNull(actualSecret);
    assertEquals(expectedName, actualSecret.get("Name"));
  }

  @Test
  public void findSecret_byArn_returnsSecret() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "find-by-arn";
    store.createSecret(secretName, "value", null, null);
    String expectedArn = store.secretArn(secretName);

    // Act
    Map<String, Object> actualSecret = store.findSecret(expectedArn);

    // Assert
    assertNotNull(actualSecret);
    assertEquals(expectedArn, actualSecret.get("ARN"));
  }

  @Test
  public void findSecret_notFound_returnsNull() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String missingName = "does-not-exist";

    // Act
    Map<String, Object> actualSecret = store.findSecret(missingName);

    // Assert
    assertNull(actualSecret);
  }

  @Test
  public void secretExists_activeSecret_returnsTrue() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "active-secret";
    store.createSecret(secretName, "value", null, null);

    // Act
    boolean actualResult = store.secretExists(secretName);

    // Assert
    assertTrue(actualResult);
  }

  @Test
  public void secretExists_nonExistentSecret_returnsFalse() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "nonexistent-secret";

    // Act
    boolean actualResult = store.secretExists(secretName);

    // Assert
    assertFalse(actualResult);
  }

  @Test
  public void listSecrets_twoSecrets_returnsBothEntries() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    store.createSecret("secret-alpha", "val-a", null, null);
    store.createSecret("secret-beta", "val-b", null, null);
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualSecrets = store.listSecrets();

    // Assert
    assertEquals(expectedCount, actualSecrets.size());
  }

  @Test
  public void reset_clearsAllSecrets() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "reset-secret";
    store.createSecret(secretName, "value", null, null);

    // Act
    store.reset();

    // Assert
    assertFalse(store.secretExists(secretName));
    assertNull(store.findSecret(secretName));
  }

  @Test
  public void secretExists_softDeletedSecret_returnsFalse() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "deleted-secret";
    store.createSecret(secretName, "value", null, null);
    store.deleteSecret(secretName, false);

    // Act
    boolean actualResult = store.secretExists(secretName);

    // Assert
    assertFalse(actualResult);
  }

  @Test
  public void createSecret_withNonNullTags_storesTags() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "tagged-create-secret";
    java.util.List<java.util.Map<String, String>> expectedTags =
        java.util.List.of(java.util.Map.of("Key", "env", "Value", "prod"));

    // Act
    java.util.Map<String, Object> actualSecret =
        store.createSecret(secretName, "value", null, expectedTags);

    // Assert
    assertEquals(expectedTags, actualSecret.get("Tags"));
  }

}
