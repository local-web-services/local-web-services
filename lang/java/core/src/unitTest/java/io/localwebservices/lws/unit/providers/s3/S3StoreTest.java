package io.localwebservices.lws.unit.providers.s3;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.s3.S3Store;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class S3StoreTest {

  @Test
  public void reset_clearsAllMaps() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucket = "my-bucket";
    store.buckets.put(expectedBucket, Map.of("Name", expectedBucket));
    store.objects.put(expectedBucket, Map.of("key.txt", new byte[] {1}));
    store.objectMetadata.put(expectedBucket, Map.of("key.txt", "text/plain"));
    store.bucketTags.put(expectedBucket, Map.of("env", "test"));
    store.bucketPolicies.put(expectedBucket, "{}");
    store.bucketWebsites.put(expectedBucket, Map.of("IndexDocument", "index.html"));
    store.multipartUploads.put("upload-1", Map.of("UploadId", "upload-1"));
    store.multipartParts.put("upload-1", Map.of(1, new byte[] {2}));

    // Act
    store.reset();

    // Assert
    assertFalse(store.buckets.containsKey(expectedBucket), "Expected map to not contain the key");
    assertFalse(store.objects.containsKey(expectedBucket), "Expected map to not contain the key");
    assertFalse(
        store.objectMetadata.containsKey(expectedBucket), "Expected map to not contain the key");
    assertFalse(
        store.bucketTags.containsKey(expectedBucket), "Expected map to not contain the key");
    assertFalse(
        store.bucketPolicies.containsKey(expectedBucket), "Expected map to not contain the key");
    assertFalse(
        store.bucketWebsites.containsKey(expectedBucket), "Expected map to not contain the key");
    assertFalse(
        store.multipartUploads.containsKey("upload-1"), "Expected map to not contain the key");
    assertFalse(
        store.multipartParts.containsKey("upload-1"), "Expected map to not contain the key");
  }

  @Test
  public void buckets_storeAndRetrieveByKey() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucket = "test-bucket";

    // Act
    store.buckets.put(expectedBucket, Map.of("Name", expectedBucket));

    // Assert
    assertTrue(
        store.buckets.containsKey(expectedBucket), "Expected map to contain the expected key");
  }
}
