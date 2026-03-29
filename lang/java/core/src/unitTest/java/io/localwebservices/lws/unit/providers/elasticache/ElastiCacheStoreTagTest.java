package io.localwebservices.lws.unit.providers.elasticache;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.elasticache.ElastiCacheStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class ElastiCacheStoreTagTest {

  @Test
  public void addTagsToResource_newResource_storesTags() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    String resourceName = "arn:aws:elasticache:us-east-1:000000000000:cluster:my-cluster";
    List<Map<String, String>> tags = List.of(Map.of("Key", "Env", "Value", "test"));
    int expectedCount = 1;

    // Act
    List<Map<String, String>> actualTags = store.addTagsToResource(resourceName, tags);

    // Assert
    assertEquals(expectedCount, actualTags.size(), "Expected actualTags.size() to match");
    assertEquals("Env", actualTags.get(0).get("Key"), "Expected tag key to match");
  }

  @Test
  public void removeTagsFromResource_existingTag_removesIt() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    String resourceName = "arn:aws:elasticache:us-east-1:000000000000:cluster:my-cluster";
    store.addTagsToResource(resourceName, List.of(Map.of("Key", "Env", "Value", "test")));
    int expectedCount = 0;

    // Act
    List<Map<String, String>> actualTags =
        store.removeTagsFromResource(resourceName, List.of("Env"));

    // Assert
    assertEquals(expectedCount, actualTags.size(), "Expected actualTags.size() to match");
  }

  @Test
  public void listTagsForResource_noTags_returnsEmptyList() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    String resourceName = "arn:aws:elasticache:us-east-1:000000000000:cluster:no-tags";

    // Act
    List<Map<String, String>> actualTags = store.listTagsForResource(resourceName);

    // Assert
    assertTrue(actualTags.isEmpty(), "Expected actualTags to be empty");
  }

  @Test
  public void reset_clearsResourceTags() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    String resourceName = "arn:aws:elasticache:us-east-1:000000000000:cluster:tagged";
    store.addTagsToResource(resourceName, List.of(Map.of("Key", "X", "Value", "y")));
    int expectedCount = 0;

    // Act
    store.reset();

    // Assert
    List<Map<String, String>> actualTags = store.listTagsForResource(resourceName);
    assertEquals(expectedCount, actualTags.size(), "Expected actualTags.size() to match");
  }
}
