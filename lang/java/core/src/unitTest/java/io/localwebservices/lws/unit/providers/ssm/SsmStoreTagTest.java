package io.localwebservices.lws.unit.providers.ssm;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.ssm.SsmStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

@SuppressWarnings("unchecked")
public class SsmStoreTagTest {

  @Test
  public void addTags_newTags_appendsToList() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "myParam";
    store.putParameter(resourceId, "v", "String", false);
    int expectedSize = 2;

    // Act
    store.addTags(
        resourceId,
        List.of(Map.of("Key", "env", "Value", "prod"), Map.of("Key", "team", "Value", "ops")));

    // Assert
    assertEquals(expectedSize, store.listTags(resourceId).size(), "Expected store.listTags(resourceId).size() to match expectedSize");
  }

  @Test
  public void removeTags_existingKey_removesTag() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "myParam";
    store.putParameter(resourceId, "v", "String", false);
    store.addTags(
        resourceId,
        List.of(Map.of("Key", "env", "Value", "prod"), Map.of("Key", "team", "Value", "ops")));
    int expectedSize = 1;

    // Act
    store.removeTags(resourceId, List.of("env"));

    // Assert
    assertEquals(expectedSize, store.listTags(resourceId).size(), "Expected store.listTags(resourceId).size() to match expectedSize");
  }

  @Test
  public void hasTagAssociated_presentKey_returnsTrue() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "myParam";
    store.putParameter(resourceId, "v", "String", false);
    store.addTags(resourceId, List.of(Map.of("Key", "env", "Value", "prod")));

    // Act
    boolean actualResult = store.hasTagAssociated(resourceId, List.of("env"));

    // Assert
    assertTrue(actualResult, "Expected condition to be true: actualResult");
  }

  @Test
  public void hasTagAssociated_absentKey_returnsFalse() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "myParam";
    store.putParameter(resourceId, "v", "String", false);

    // Act
    boolean actualResult = store.hasTagAssociated(resourceId, List.of("env"));

    // Assert
    assertFalse(actualResult, "Expected condition to be false: actualResult");
  }

  @Test
  public void listTags_noTags_returnsEmptyList() {
    // Arrange
    SsmStore store = new SsmStore();
    String resourceId = "myParam";
    store.putParameter(resourceId, "v", "String", false);

    // Act
    List<Map<String, String>> actualTags = store.listTags(resourceId);

    // Assert
    assertTrue(actualTags.isEmpty(), "Expected actualTags to be empty");
  }
}
