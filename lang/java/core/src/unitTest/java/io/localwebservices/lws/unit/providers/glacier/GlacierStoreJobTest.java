package io.localwebservices.lws.unit.providers.glacier;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.glacier.GlacierStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class GlacierStoreJobTest {

  @Test
  public void initiateJob_returnsJobId() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    Map<String, Object> jobParams = Map.of("Type", "InventoryRetrieval");

    // Act
    String actualJobId = store.initiateJob(vaultName, jobParams);

    // Assert
    assertNotNull(actualJobId, "Expected actualJobId to not be null");
    assertFalse(actualJobId.isEmpty(), "Expected actualJobId to not be empty");
  }

  @Test
  public void initiateJob_storesJobWithStatusSucceeded() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    String expectedStatusCode = "Succeeded";
    Map<String, Object> jobParams = Map.of("Type", "InventoryRetrieval");
    String jobId = store.initiateJob(vaultName, jobParams);

    // Act
    Map<String, Object> actualJob = store.getJob(vaultName, jobId);

    // Assert
    assertNotNull(actualJob, "Expected actualJob to not be null");
    assertEquals(expectedStatusCode, actualJob.get("StatusCode"), "Expected actualJob.get("StatusCode") to equal expectedStatusCode");
  }

  @Test
  public void getJob_unknownJobId_returnsNull() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    String unknownJobId = "unknown";

    // Act
    Map<String, Object> actualJob = store.getJob(vaultName, unknownJobId);

    // Assert
    assertNull(actualJob, "Expected actualJob to be null");
  }

  @Test
  public void listJobs_afterInitiate_returnsOne() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault1";
    int expectedJobCount = 1;
    store.initiateJob(vaultName, Map.of("Type", "InventoryRetrieval"));

    // Act
    List<Map<String, Object>> actualJobs = store.listJobs(vaultName);

    // Assert
    assertEquals(expectedJobCount, actualJobs.size(), "Expected actualJobs.size() to match expectedJobCount");
  }

  @Test
  public void listJobs_unknownVault_returnsEmpty() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "non-existent-vault";
    int expectedJobCount = 0;

    // Act
    List<Map<String, Object>> actualJobs = store.listJobs(vaultName);

    // Assert
    assertNotNull(actualJobs, "Expected actualJobs to not be null");
    assertEquals(expectedJobCount, actualJobs.size(), "Expected actualJobs.size() to match expectedJobCount");
  }
}
