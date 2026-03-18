package io.localwebservices.lws.unit.providers.s3;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.s3.S3Store;
import java.util.LinkedHashMap;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class S3StoreMultipartTest {

  @Test
  public void multipartUploads_putAndGet_storesUploadRecord() {
    // Arrange
    S3Store store = new S3Store();
    String expectedUploadId = "upload-1";

    // Act
    store.multipartUploads.put(expectedUploadId, Map.of("UploadId", expectedUploadId));

    // Assert
    assertNotNull(store.multipartUploads.get(expectedUploadId));
  }

  @Test
  public void multipartParts_putAndGet_storesPartBytes() {
    // Arrange
    S3Store store = new S3Store();
    String expectedUploadId = "upload-1";
    int expectedPartNumber = 1;
    byte[] expectedPartBytes = "part".getBytes();

    // Act
    store
        .multipartParts
        .computeIfAbsent(expectedUploadId, k -> new LinkedHashMap<>())
        .put(expectedPartNumber, expectedPartBytes);

    // Assert
    byte[] actualPartBytes = store.multipartParts.get(expectedUploadId).get(expectedPartNumber);
    assertArrayEquals(expectedPartBytes, actualPartBytes);
  }

  @Test
  public void reset_clearsMultipartUploads() {
    // Arrange
    S3Store store = new S3Store();
    store.multipartUploads.put("upload-1", Map.of("UploadId", "upload-1"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.multipartUploads.isEmpty());
  }

  @Test
  public void reset_clearsMultipartParts() {
    // Arrange
    S3Store store = new S3Store();
    store
        .multipartParts
        .computeIfAbsent("upload-1", k -> new LinkedHashMap<>())
        .put(1, "part".getBytes());

    // Act
    store.reset();

    // Assert
    assertTrue(store.multipartParts.isEmpty());
  }
}
