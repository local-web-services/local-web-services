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
    assertTrue(store.buckets.isEmpty(), "Expected store.buckets to be empty");
    assertTrue(store.objects.isEmpty(), "Expected store.objects to be empty");
    assertTrue(store.objectMetadata.isEmpty(), "Expected store.objectMetadata to be empty");
    assertTrue(store.bucketTags.isEmpty(), "Expected store.bucketTags to be empty");
    assertTrue(store.bucketPolicies.isEmpty(), "Expected store.bucketPolicies to be empty");
    assertTrue(store.bucketWebsites.isEmpty(), "Expected store.bucketWebsites to be empty");
    assertTrue(store.multipartUploads.isEmpty(), "Expected store.multipartUploads to be empty");
    assertTrue(store.multipartParts.isEmpty(), "Expected store.multipartParts to be empty");
  }
}
