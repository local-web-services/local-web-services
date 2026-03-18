package io.localwebservices.lws.unit.providers.s3;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.s3.S3Store;
import java.util.LinkedHashMap;
import java.util.concurrent.ConcurrentHashMap;
import org.junit.jupiter.api.Test;

public class S3StoreObjectTest {

  @Test
  public void objects_putAndGet_storesObjectBytes() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucketName = "my-bucket";
    String expectedKey = "key.txt";
    byte[] expectedBytes = "hello".getBytes();

    // Act
    store
        .objects
        .computeIfAbsent(expectedBucketName, k -> new ConcurrentHashMap<>())
        .put(expectedKey, expectedBytes);

    // Assert
    byte[] actualBytes = store.objects.get(expectedBucketName).get(expectedKey);
    assertArrayEquals(expectedBytes, actualBytes);
  }

  @Test
  public void objects_remove_deletesObject() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucketName = "my-bucket";
    String expectedKey = "key.txt";
    store
        .objects
        .computeIfAbsent(expectedBucketName, k -> new ConcurrentHashMap<>())
        .put(expectedKey, "hello".getBytes());

    // Act
    store.objects.get(expectedBucketName).remove(expectedKey);

    // Assert
    assertNull(store.objects.get(expectedBucketName).get(expectedKey));
  }

  @Test
  public void objectMetadata_put_storesContentType() {
    // Arrange
    S3Store store = new S3Store();
    String expectedMetadataKey = "my-bucket/key";
    String expectedContentType = "text/plain";

    // Act
    store
        .objectMetadata
        .computeIfAbsent(expectedMetadataKey, k -> new LinkedHashMap<>())
        .put("Content-Type", expectedContentType);

    // Assert
    String actualContentType = store.objectMetadata.get(expectedMetadataKey).get("Content-Type");
    assertEquals(expectedContentType, actualContentType);
  }

  @Test
  public void reset_clearsObjects() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucketName = "my-bucket";
    store
        .objects
        .computeIfAbsent(expectedBucketName, k -> new ConcurrentHashMap<>())
        .put("key.txt", "hello".getBytes());

    // Act
    store.reset();

    // Assert
    assertTrue(store.objects.isEmpty());
  }
}
