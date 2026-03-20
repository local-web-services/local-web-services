package io.localwebservices.lws.unit.providers.s3;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.s3.S3Store;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class S3StoreBucketTest {

  @Test
  public void buckets_putAndGet_storesBucketData() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucketName = "my-bucket";

    // Act
    store.buckets.put(expectedBucketName, Map.of("BucketName", expectedBucketName));

    // Assert
    String actualBucketName = (String) store.buckets.get(expectedBucketName).get("BucketName");
    assertEquals(expectedBucketName, actualBucketName, "Expected actualBucketName to equal expectedBucketName");
  }

  @Test
  public void buckets_remove_deletesBucket() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucketName = "my-bucket";
    store.buckets.put(expectedBucketName, Map.of("BucketName", expectedBucketName));

    // Act
    store.buckets.remove(expectedBucketName);

    // Assert
    assertNull(store.buckets.get(expectedBucketName), "Expected store.buckets.get(expectedBucketName) to be null");
  }

  @Test
  public void bucketTags_putAndGet_storesTagMap() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucketName = "my-bucket";
    String expectedTagKey = "env";
    String expectedTagValue = "prod";

    // Act
    store.bucketTags.put(expectedBucketName, Map.of(expectedTagKey, expectedTagValue));

    // Assert
    String actualTagValue = store.bucketTags.get(expectedBucketName).get(expectedTagKey);
    assertEquals(expectedTagValue, actualTagValue, "Expected actualTagValue to equal expectedTagValue");
  }

  @Test
  public void bucketPolicies_putAndGet_storesPolicy() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucketName = "my-bucket";
    String expectedPolicy = "{}";

    // Act
    store.bucketPolicies.put(expectedBucketName, expectedPolicy);

    // Assert
    String actualPolicy = store.bucketPolicies.get(expectedBucketName);
    assertEquals(expectedPolicy, actualPolicy, "Expected actualPolicy to equal expectedPolicy");
  }

  @Test
  public void reset_clearsBuckets() {
    // Arrange
    S3Store store = new S3Store();
    store.buckets.put("my-bucket", Map.of("BucketName", "my-bucket"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.buckets.isEmpty(), "Expected store.buckets to be empty");
  }

  @Test
  public void reset_clearsBucketTags() {
    // Arrange
    S3Store store = new S3Store();
    store.bucketTags.put("my-bucket", Map.of("env", "prod"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.bucketTags.isEmpty(), "Expected store.bucketTags to be empty");
  }

  @Test
  public void reset_clearsBucketPolicies() {
    // Arrange
    S3Store store = new S3Store();
    store.bucketPolicies.put("my-bucket", "{}");

    // Act
    store.reset();

    // Assert
    assertTrue(store.bucketPolicies.isEmpty(), "Expected store.bucketPolicies to be empty");
  }
}
