package io.localwebservices.lws.unit.providers.s3;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.s3.S3Store;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class S3StoreBucketConfigTest {

  @Test
  public void bucketWebsites_putAndGet_storesConfig() {
    // Arrange
    S3Store store = new S3Store();
    String expectedBucketName = "my-bucket";
    String expectedIndexDocument = "index.html";

    // Act
    store.bucketWebsites.put(expectedBucketName, Map.of("IndexDocument", expectedIndexDocument));

    // Assert
    String actualIndexDocument = store.bucketWebsites.get(expectedBucketName).get("IndexDocument");
    assertEquals(expectedIndexDocument, actualIndexDocument, "Expected actualIndexDocument to equal expectedIndexDocument");
  }

  @Test
  public void reset_clearsBucketWebsites() {
    // Arrange
    S3Store store = new S3Store();
    store.bucketWebsites.put("my-bucket", Map.of("IndexDocument", "index.html"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.bucketWebsites.isEmpty(), "Expected store.bucketWebsites to be empty");
  }
}
