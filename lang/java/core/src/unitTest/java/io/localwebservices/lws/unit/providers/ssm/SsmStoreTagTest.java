package io.localwebservices.lws.unit.providers.ssm;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.ssm.SsmStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SsmStoreTagTest {

  @Test
  public void addTags_newTags_appendsToList() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "/tagged/param";
    store.putParameter(resourceId, "v", "String", false);
    List<Map<String, Object>> tags =
        List.of(
            Map.of("Key", "env", "Value", "prod"),
            Map.of("Key", "team", "Value", "platform"));
    int expectedTagCount = 2;

    // Act
    store.addTags(resourceId, tags);

    // Assert
    assertEquals(expectedTagCount, store.listTags(resourceId).size());
  }

  @Test
  public void removeTags_existingKey_removesTag() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "/remove/tag/param";
    store.putParameter(resourceId, "v", "String", false);
    store.addTags(
        resourceId,
        List.of(
            Map.of("Key", "env", "Value", "prod"),
            Map.of("Key", "team", "Value", "platform")));
    int expectedTagCount = 1;
    String expectedRemainingKey = "team";

    // Act
    store.removeTags(resourceId, List.of("env"));

    // Assert
    List<Map<String, String>> actualTags = store.listTags(resourceId);
    assertEquals(expectedTagCount, actualTags.size());
    assertEquals(expectedRemainingKey, actualTags.get(0).get("Key"));
  }

  @Test
  public void hasTagAssociated_presentKey_returnsTrue() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "/has/tag/param";
    store.putParameter(resourceId, "v", "String", false);
    store.addTags(resourceId, List.of(Map.of("Key", "env", "Value", "staging")));

    // Act
    boolean actualResult = store.hasTagAssociated(resourceId, List.of("env"));

    // Assert
    assertTrue(actualResult);
  }

  @Test
  public void hasTagAssociated_absentKey_returnsFalse() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "/absent/tag/param";
    store.putParameter(resourceId, "v", "String", false);

    // Act
    boolean actualResult = store.hasTagAssociated(resourceId, List.of("env"));

    // Assert
    assertFalse(actualResult);
  }

  @Test
  public void listTags_noTags_returnsEmptyList() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "/no/tags/param";
    store.putParameter(resourceId, "v", "String", false);
    int expectedSize = 0;

    // Act
    List<Map<String, String>> actualTags = store.listTags(resourceId);

    // Assert
    assertEquals(expectedSize, actualTags.size());
  }
}
