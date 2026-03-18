package io.localwebservices.lws.unit.providers.s3;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.s3.S3Store;
import java.util.LinkedHashMap;
import org.junit.jupiter.api.Test;

public class S3StoreObjectMetadataTest {

  @Test
  public void objectMetadata_putCustomMetadata_roundtrip() {
    // Arrange
    S3Store store = new S3Store();
    String expectedMetadataKey = "my-bucket/key.txt";
    String expectedAuthor = "alice";

    // Act
    store
        .objectMetadata
        .computeIfAbsent(expectedMetadataKey, k -> new LinkedHashMap<>())
        .put("x-amz-meta-author", expectedAuthor);

    // Assert
    String actualAuthor = store.objectMetadata.get(expectedMetadataKey).get("x-amz-meta-author");
    assertEquals(expectedAuthor, actualAuthor);
  }

  @Test
  public void objectMetadata_multipleKeys_allPresent() {
    // Arrange
    S3Store store = new S3Store();
    String expectedMetadataKey = "my-bucket/key.txt";
    String expectedContentType = "application/json";
    String expectedCacheControl = "max-age=3600";

    // Act
    store
        .objectMetadata
        .computeIfAbsent(expectedMetadataKey, k -> new LinkedHashMap<>())
        .put("Content-Type", expectedContentType);
    store.objectMetadata.get(expectedMetadataKey).put("Cache-Control", expectedCacheControl);

    // Assert
    String actualContentType = store.objectMetadata.get(expectedMetadataKey).get("Content-Type");
    String actualCacheControl = store.objectMetadata.get(expectedMetadataKey).get("Cache-Control");
    assertEquals(expectedContentType, actualContentType);
    assertEquals(expectedCacheControl, actualCacheControl);
  }

  @Test
  public void reset_clearsObjectMetadata() {
    // Arrange
    S3Store store = new S3Store();
    String expectedMetadataKey = "my-bucket/key.txt";
    store
        .objectMetadata
        .computeIfAbsent(expectedMetadataKey, k -> new LinkedHashMap<>())
        .put("Content-Type", "text/html");

    // Act
    store.reset();

    // Assert
    assertTrue(store.objectMetadata.isEmpty());
  }
}
