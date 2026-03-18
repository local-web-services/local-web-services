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
  public void createSecret_newName_hasNameAndArn() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String expectedName = "mySecret";

    // Act
    Map<String, Object> actualSecret = store.createSecret(expectedName, "{}", null, null);

    // Assert
    assertEquals(expectedName, actualSecret.get("Name"));
    assertNotNull(actualSecret.get("ARN"));
  }

  @Test
  public void secretArn_returnsArnContainingName() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    String expectedArnPrefix = "arn:aws:secretsmanager";

    // Act
    String actualArn = store.secretArn(secretName);

    // Assert
    assertTrue(actualArn.contains(secretName));
    assertTrue(actualArn.contains(expectedArnPrefix));
  }

  @Test
  public void findSecret_byName_returnsSecret() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    store.createSecret(secretName, "{}", null, null);

    // Act
    Map<String, Object> actualSecret = store.findSecret(secretName);

    // Assert
    assertNotNull(actualSecret);
  }

  @Test
  public void findSecret_byArn_returnsSecret() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    Map<String, Object> created = store.createSecret(secretName, "{}", null, null);
    String expectedArn = (String) created.get("ARN");

    // Act
    Map<String, Object> actualSecret = store.findSecret(expectedArn);

    // Assert
    assertNotNull(actualSecret);
  }

  @Test
  public void findSecret_notFound_returnsNull() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();

    // Act
    Map<String, Object> actualSecret = store.findSecret("doesNotExist");

    // Assert
    assertNull(actualSecret);
  }

  @Test
  public void secretExists_activeSecret_returnsTrue() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    store.createSecret(secretName, "{}", null, null);

    // Act
    boolean actualResult = store.secretExists(secretName);

    // Assert
    assertTrue(actualResult);
  }

  @Test
  public void secretExists_nonExistent_returnsFalse() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();

    // Act
    boolean actualResult = store.secretExists("mySecret");

    // Assert
    assertFalse(actualResult);
  }

  @Test
  public void listSecrets_twoSecrets_returnsBothEntries() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    store.createSecret("s1", "{}", null, null);
    store.createSecret("s2", "{}", null, null);
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualSecrets = store.listSecrets();

    // Assert
    assertEquals(expectedSize, actualSecrets.size());
  }
}
