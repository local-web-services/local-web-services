package io.localwebservices.lws.unit.providers.secretsmanager;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.secretsmanager.SecretsManagerStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SecretsManagerStoreBranchTest {

  @Test
  public void reset_afterCreatingSecrets_clearsAllSecrets() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    store.createSecret("s1", "{}", null, null);
    store.createSecret("s2", "{}", null, null);

    // Act
    store.reset();

    // Assert
    List<Map<String, Object>> actualSecrets = store.listSecrets();
    assertTrue(actualSecrets.isEmpty(), "Expected actualSecrets to be empty");
    boolean actualExists = store.secretExists("s1");
    assertFalse(actualExists, "Expected condition to be false: actualExists");
  }

  @Test
  public void createSecret_withNonNullTags_storesTags() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    List<Map<String, String>> expectedTags = List.of(Map.of("Key", "env", "Value", "prod"));

    // Act
    Map<String, Object> actualSecret = store.createSecret("mySecret", "{}", null, expectedTags);

    // Assert
    assertNotNull(actualSecret.get("Tags"), "Expected values to match");
  }

  @Test
  public void findSecret_wrongArn_storeHasItems_returnsNull() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    store.createSecret("realSecret", "{}", null, null);
    String expectedArn = "arn:aws:secretsmanager:us-east-1:000000000000:secret:wrongSecret";

    // Act
    Map<String, Object> actualSecret = store.findSecret(expectedArn);

    // Assert
    assertNull(actualSecret, "Expected actualSecret to be null");
  }

  @Test
  public void deleteSecret_softDelete_nonExistentName_noException() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    store.createSecret("realSecret", "{}", null, null);

    // Act
    assertDoesNotThrow(() -> store.deleteSecret("doesNotExist", false));

    // Assert
    boolean actualExists = store.secretExists("realSecret");
    assertTrue(actualExists, "Expected condition to be true: actualExists");
  }

  @Test
  public void secretExists_deletedSecret_returnsFalse() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    store.createSecret("mySecret", "{}", null, null);
    store.deleteSecret("mySecret", false);

    // Act
    boolean actualExists = store.secretExists("mySecret");

    // Assert
    assertFalse(actualExists, "Expected condition to be false: actualExists");
  }
}
