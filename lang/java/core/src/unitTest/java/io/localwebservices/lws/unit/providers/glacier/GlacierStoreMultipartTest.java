package io.localwebservices.lws.unit.providers.glacier;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.glacier.GlacierStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class GlacierStoreMultipartTest {

  @Test
  public void initiateMultipartUpload_withDescription_storesDescription() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    String description = "my-archive-description";
    String partSize = "1048576";
    String expectedDescription = "my-archive-description";

    // Act
    String actualUploadId = store.initiateMultipartUpload(vaultName, partSize, description);
    List<Map<String, Object>> actualUploads = store.listMultipartUploads(vaultName);

    // Assert
    assertNotNull(actualUploadId, "Expected actualUploadId to not be null");
    assertFalse(actualUploads.isEmpty(), "Expected at least one upload");
    assertEquals(
        expectedDescription,
        actualUploads.get(0).get("ArchiveDescription"),
        "Expected description to match");
  }

  @Test
  public void initiateMultipartUpload_withNullDescription_storesEmptyDescription() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    String partSize = "1048576";
    String expectedDescription = "";

    // Act
    String actualUploadId = store.initiateMultipartUpload(vaultName, partSize, null);
    List<Map<String, Object>> actualUploads = store.listMultipartUploads(vaultName);

    // Assert
    assertNotNull(actualUploadId, "Expected actualUploadId to not be null");
    assertFalse(actualUploads.isEmpty(), "Expected at least one upload");
    assertEquals(
        expectedDescription,
        actualUploads.get(0).get("ArchiveDescription"),
        "Expected description to be empty string for null input");
  }

  @Test
  public void multipartUploadExists_afterInitiate_returnsTrue() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    String uploadId = store.initiateMultipartUpload(vaultName, "1048576", "desc");

    // Act
    boolean actualExists = store.multipartUploadExists(vaultName, uploadId);

    // Assert
    assertTrue(actualExists, "Expected actualExists to be true after initiate");
  }

  @Test
  public void multipartUploadExists_unknownId_returnsFalse() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";

    // Act
    boolean actualExists = store.multipartUploadExists(vaultName, "unknown-id");

    // Assert
    assertFalse(actualExists, "Expected actualExists to be false for unknown id");
  }

  @Test
  public void completeMultipartUpload_removesUploadAndCreatesArchive() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    String uploadId = store.initiateMultipartUpload(vaultName, "1048576", "desc");

    // Act
    String actualArchiveId = store.completeMultipartUpload(vaultName, uploadId);

    // Assert
    assertNotNull(actualArchiveId, "Expected actualArchiveId to not be null");
    assertFalse(
        store.multipartUploadExists(vaultName, uploadId),
        "Expected upload to be removed after complete");
  }

  @Test
  public void abortMultipartUpload_removesUpload() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    String uploadId = store.initiateMultipartUpload(vaultName, "1048576", "desc");

    // Act
    store.abortMultipartUpload(vaultName, uploadId);

    // Assert
    assertFalse(
        store.multipartUploadExists(vaultName, uploadId),
        "Expected upload to be removed after abort");
  }
}
