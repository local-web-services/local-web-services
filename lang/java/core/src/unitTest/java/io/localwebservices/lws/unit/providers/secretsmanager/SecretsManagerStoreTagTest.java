package io.localwebservices.lws.unit.providers.secretsmanager;

import static org.junit.jupiter.api.Assertions.assertEquals;

import io.localwebservices.lws.providers.secretsmanager.SecretsManagerStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SecretsManagerStoreTagTest {

  @Test
  public void tagResource_newTags_appendsToList() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "tagged-secret";
    store.createSecret(secretName, "value", null, null);
    List<Map<String, Object>> tags =
        List.of(
            Map.of("Key", "env", "Value", "prod"),
            Map.of("Key", "owner", "Value", "platform-team"));
    int expectedTagCount = 2;

    // Act
    store.tagResource(secretName, tags);

    // Assert
    assertEquals(expectedTagCount, store.listTags(secretName).size());
  }

  @Test
  public void untagResource_existingKey_removesTag() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "untag-secret";
    store.createSecret(secretName, "value", null, null);
    store.tagResource(
        secretName,
        List.of(
            Map.of("Key", "env", "Value", "prod"),
            Map.of("Key", "owner", "Value", "platform-team")));
    int expectedTagCount = 1;
    String expectedRemainingKey = "owner";

    // Act
    store.untagResource(secretName, List.of("env"));

    // Assert
    List<Map<String, String>> actualTags = store.listTags(secretName);
    assertEquals(expectedTagCount, actualTags.size());
    assertEquals(expectedRemainingKey, actualTags.get(0).get("Key"));
  }

  @Test
  public void listTags_noTags_returnsEmptyList() {
    // Arrange
    SecretsManagerStore store = new SecretsManagerStore();
    String secretName = "untagged-secret";
    store.createSecret(secretName, "value", null, null);
    int expectedSize = 0;

    // Act
    List<Map<String, String>> actualTags = store.listTags(secretName);

    // Assert
    assertEquals(expectedSize, actualTags.size());
  }
}
