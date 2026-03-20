package io.localwebservices.lws.unit.providers.secretsmanager;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.secretsmanager.SecretsManagerStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

@SuppressWarnings("unchecked")
public class SecretsManagerStoreTagTest {

  @Test
  public void tagResource_newTags_appendsToList() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    store.createSecret(secretName, "{}", null, null);
    int expectedSize = 1;

    // Act
    store.tagResource(secretName, List.of(Map.of("Key", "env", "Value", "prod")));

    // Assert
    assertEquals(
        expectedSize,
        store.listTags(secretName).size(),
        "Expected store.listTags(secretName).size() to match expectedSize");
  }

  @Test
  public void untagResource_existingKey_removesTag() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    store.createSecret(secretName, "{}", null, null);
    store.tagResource(
        secretName,
        List.of(Map.of("Key", "env", "Value", "prod"), Map.of("Key", "team", "Value", "ops")));
    int expectedSize = 1;

    // Act
    store.untagResource(secretName, List.of("env"));

    // Assert
    assertEquals(
        expectedSize,
        store.listTags(secretName).size(),
        "Expected store.listTags(secretName).size() to match expectedSize");
  }

  @Test
  public void listTags_noTags_returnsEmptyList() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "mySecret";
    store.createSecret(secretName, "{}", null, null);

    // Act
    List<Map<String, String>> actualTags = store.listTags(secretName);

    // Assert
    assertTrue(actualTags.isEmpty(), "Expected actualTags to be empty");
  }
}
