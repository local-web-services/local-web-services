package io.localwebservices.lws.unit.providers.s3;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.s3.S3Store;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.junit.jupiter.api.Test;

public class S3StoreResetTest {

  @Test
  public void reset_clearsAllMaps() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucketName = "my-bucket";
    store.buckets.put(expectedBucketName, Map.of("BucketName", expectedBucketName));
    store
        .objects
        .computeIfAbsent(expectedBucketName, k -> new ConcurrentHashMap<>())
        .put("key.txt", "data".getBytes());
    store
        .objectMetadata
        .computeIfAbsent(expectedBucketName + "/key.txt", k -> new LinkedHashMap<>())
        .put("Content-Type", "text/plain");
    store.bucketTags.put(expectedBucketName, Map.of("env", "test"));
    store.bucketPolicies.put(expectedBucketName, "{}");
    store.bucketWebsites.put(expectedBucketName, Map.of("IndexDocument", "index.html"));
    store.multipartUploads.put("upload-1", Map.of("UploadId", "upload-1"));
    store
        .multipartParts
        .computeIfAbsent("upload-1", k -> new LinkedHashMap<>())
        .put(1, "part".getBytes());

    // Act
    store.reset();

    // Assert
    assertTrue(store.buckets.isEmpty());
    assertTrue(store.objects.isEmpty());
    assertTrue(store.objectMetadata.isEmpty());
    assertTrue(store.bucketTags.isEmpty());
    assertTrue(store.bucketPolicies.isEmpty());
    assertTrue(store.bucketWebsites.isEmpty());
    assertTrue(store.multipartUploads.isEmpty());
    assertTrue(store.multipartParts.isEmpty());
  }
}
