package io.localwebservices.lws.unit.providers.glacier;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.localwebservices.lws.providers.glacier.GlacierStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class GlacierStoreArchiveTest {

  @Test
  public void uploadArchive_returnsArchiveId() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    String description = "my archive";
    int size = 100;

    // Act
    String actualArchiveId = store.uploadArchive(vaultName, description, size);

    // Assert
    assertNotNull(actualArchiveId, "Expected actualArchiveId to not be null");
    assertFalse(actualArchiveId.isEmpty(), "Expected actualArchiveId to not be empty");
  }

  @Test
  public void uploadArchive_storesArchive() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    int expectedArchiveCount = 1;
    store.uploadArchive(vaultName, "desc", 100);

    // Act
    List<Map<String, Object>> actualArchives = store.listArchives(vaultName);

    // Assert
    assertEquals(
        expectedArchiveCount,
        actualArchives.size(),
        "Expected actualArchives.size() to match expectedArchiveCount");
  }

  @Test
  public void deleteArchive_removesArchive() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    int expectedArchiveCount = 0;
    String archiveId = store.uploadArchive(vaultName, "desc", 100);

    // Act
    store.deleteArchive(vaultName, archiveId);

    // Assert
    List<Map<String, Object>> actualArchives = store.listArchives(vaultName);
    assertEquals(
        expectedArchiveCount,
        actualArchives.size(),
        "Expected actualArchives.size() to match expectedArchiveCount");
  }

  @Test
  public void listArchives_unknownVault_returnsEmptyList() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "non-existent-vault";
    int expectedArchiveCount = 0;

    // Act
    List<Map<String, Object>> actualArchives = store.listArchives(vaultName);

    // Assert
    assertNotNull(actualArchives, "Expected actualArchives to not be null");
    assertEquals(
        expectedArchiveCount,
        actualArchives.size(),
        "Expected actualArchives.size() to match expectedArchiveCount");
  }
}
