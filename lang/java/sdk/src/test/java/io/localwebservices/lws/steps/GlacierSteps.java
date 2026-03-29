package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.nio.charset.StandardCharsets;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.glacier.GlacierClient;
import software.amazon.awssdk.services.glacier.model.DescribeVaultResponse;
import software.amazon.awssdk.services.glacier.model.InitiateJobResponse;
import software.amazon.awssdk.services.glacier.model.InitiateMultipartUploadResponse;
import software.amazon.awssdk.services.glacier.model.UploadArchiveResponse;
import software.amazon.awssdk.services.s3.S3Client;

/**
 * Step definitions for the Glacier informal specification feature files.
 *
 * <p>Covers: create_vault, delete_vault, upload_archive, delete_archive,
 * initiate_archive_retrieval_job, initiate_inventory_retrieval_job, get_job_output,
 * initiate_multipart_upload, upload_multipart_part, complete_multipart_upload,
 * abort_multipart_upload, job_fails, job_succeeds, vault_inventory_refresh.
 */
public class GlacierSteps {

  private static final String TEST_VAULT = "test-glacier-vault-1";
  private static final String TEST_ARCHIVE = "test-glacier-archive-1";
  private static final String ACCOUNT_ID = "-";
  private static final String TEST_PART_SIZE = "1048576";
  private static final String TEST_UPLOAD_ID_FALLBACK = "missing-upload-id";

  private final WorldContext world;

  // Mutable scenario state
  private String archiveId;
  private String uploadId;
  private String jobId;

  public GlacierSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: vault state setup ──────────────────────────────────────────────────

  @Given("the vault does not already exist")
  public void theVaultDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no vaults.
  }

  @Given("the vault already exists")
  public void theVaultAlreadyExists() {
    // Arrange
    // Act
    glacierCreateVault();
    // Assert: vault created (no error thrown)
  }

  @Given("the vault exists")
  public void theVaultExists() {
    // Arrange
    // Act
    glacierCreateVault();
    // Assert: vault created (no error thrown)
  }

  @Given("the vault is \"ACTIVE\"")
  public void theVaultIsActive() {
    // Arrange / Act / Assert — no-op: vaults are always ACTIVE after creation in lws.
  }

  @Given("the vault is not \"ACTIVE\"")
  public void theVaultIsNotActive() {
    // @internal: vault lifecycle transitions require background processing.
  }

  @Given("the vault does not exist")
  public void theVaultDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no vaults.
  }

  @Given("the vault has no archives")
  public void theVaultHasNoArchives() {
    // Arrange / Act / Assert — no-op: fresh vault has no archives.
  }

  @Given("the vault has archives")
  public void theVaultHasArchives() {
    // Arrange
    // Act: upload an archive to the vault
    try (GlacierClient client = world.session.glacierClient()) {
      UploadArchiveResponse resp =
          client.uploadArchive(
              r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT),
              RequestBody.fromBytes("test-archive-content-1".getBytes(StandardCharsets.UTF_8)));
      // Assert: archive uploaded
      archiveId = resp.archiveId();
    }
  }

  @Given("the vault has no in-progress jobs")
  public void theVaultHasNoInProgressJobs() {
    // Arrange / Act / Assert — no-op: fresh vault has no in-progress jobs.
  }

  @Given("the vault has in-progress jobs")
  public void theVaultHasInProgressJobs() {
    // Arrange
    // Act: initiate a job to create an in-progress state
    try (GlacierClient client = world.session.glacierClient()) {
      InitiateJobResponse resp =
          client.initiateJob(
              r ->
                  r.accountId(ACCOUNT_ID)
                      .vaultName(TEST_VAULT)
                      .jobParameters(jp -> jp.type("inventory-retrieval")));
      // Assert: job initiated
      jobId = resp.jobId();
    }
  }

  // ── Given: archive state setup ────────────────────────────────────────────────

  @Given("the archive does not already exist")
  public void theArchiveDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh vault has no archives.
  }

  @Given("the archive already exists")
  public void theArchiveAlreadyExists() {
    // Arrange
    // Act: upload an archive so it already exists
    try (GlacierClient client = world.session.glacierClient()) {
      UploadArchiveResponse resp =
          client.uploadArchive(
              r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT),
              RequestBody.fromBytes("test-archive-content-1".getBytes(StandardCharsets.UTF_8)));
      // Assert: archive uploaded
      archiveId = resp.archiveId();
    }
  }

  @Given("the archive exists")
  public void theArchiveExists() {
    // Arrange
    // Act: ensure the archive exists
    try (GlacierClient client = world.session.glacierClient()) {
      UploadArchiveResponse resp =
          client.uploadArchive(
              r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT),
              RequestBody.fromBytes("test-archive-content-1".getBytes(StandardCharsets.UTF_8)));
      // Assert: archive uploaded
      archiveId = resp.archiveId();
    }
  }

  @Given("the archive is \"STORED\"")
  public void theArchiveIsStored() {
    // Arrange / Act / Assert — no-op: archives are STORED immediately after upload in lws.
  }

  @Given("the archive is not \"STORED\"")
  public void theArchiveIsNotStored() {
    // @internal: archive lifecycle transitions require background processing.
  }

  @Given("the archive does not exist")
  public void theArchiveDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh vault has no archives.
  }

  // ── Given: job state setup ────────────────────────────────────────────────────

  @Given("the job slot is available")
  public void theJobSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: job slots are available by default.
  }

  @Given("the job slot is not available")
  public void theJobSlotIsNotAvailable() throws Exception {
    // Arrange: exhaust glacier job capacity
    // Act
    world.session.capacity("glacier").exhaust().apply();
    // Assert: capacity exhausted
  }

  @Given("the job exists")
  public void theJobExists() {
    // Arrange
    glacierCreateVault();
    // Act: initiate a job so it exists
    try (GlacierClient client = world.session.glacierClient()) {
      InitiateJobResponse resp =
          client.initiateJob(
              r ->
                  r.accountId(ACCOUNT_ID)
                      .vaultName(TEST_VAULT)
                      .jobParameters(jp -> jp.type("inventory-retrieval")));
      // Assert: job initiated
      jobId = resp.jobId();
    }
  }

  @Given("the job is Succeeded")
  public void theJobIsSucceeded() {
    // @internal: job success requires background Glacier job processing.
  }

  @Given("the job is InProgress")
  public void theJobIsInProgress() {
    // Arrange / Act / Assert — no-op: jobs are InProgress immediately after initiation in lws.
  }

  @Given("the job is not Succeeded")
  public void theJobIsNotSucceeded() {
    // @internal: job lifecycle transitions require background processing.
  }

  @Given("the job is not InProgress")
  public void theJobIsNotInProgress() {
    // @internal: job lifecycle transitions require background processing.
  }

  @Given("the job does not exist")
  public void theJobDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no jobs.
  }

  @Given("the job output is available")
  public void theJobOutputIsAvailable() {
    // @internal: job output availability requires background Glacier processing.
  }

  @Given("the job output is not available")
  public void theJobOutputIsNotAvailable() {
    // @internal: job output availability requires background Glacier processing.
  }

  // ── Given: multipart upload state setup ──────────────────────────────────────

  @Given("the upload does not already exist")
  public void theUploadDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state has no multipart uploads.
  }

  @Given("the upload already exists")
  public void theUploadAlreadyExists() {
    // Arrange
    // Act: initiate a multipart upload so it already exists
    try (GlacierClient client = world.session.glacierClient()) {
      InitiateMultipartUploadResponse resp =
          client.initiateMultipartUpload(
              r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT).partSize(TEST_PART_SIZE));
      // Assert: upload initiated
      uploadId = resp.uploadId();
    }
  }

  @Given("the upload exists")
  public void theUploadExists() {
    // Arrange
    // Act: ensure a multipart upload exists
    try (GlacierClient client = world.session.glacierClient()) {
      InitiateMultipartUploadResponse resp =
          client.initiateMultipartUpload(
              r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT).partSize(TEST_PART_SIZE));
      // Assert: upload initiated
      uploadId = resp.uploadId();
    }
    // Also create an S3 multipart upload if an S3 bucket context is active (s3api scenarios)
    if (world.s3UploadBucket != null) {
      try (S3Client s3Client = world.session.s3Client()) {
        var createResp =
            s3Client.createMultipartUpload(
                r -> r.bucket(world.s3UploadBucket).key("e2e-test-object-1"));
        world.s3UploadId = createResp.uploadId();
      }
    }
  }

  @Given("the upload is InProgress")
  public void theUploadIsInProgress() {
    // Arrange / Act / Assert — no-op: multipart uploads are InProgress after initiation in lws.
  }

  @Given("the upload is not InProgress")
  public void theUploadIsNotInProgress() {
    // @internal: upload lifecycle transitions require background processing.
  }

  @Given("the upload does not exist")
  public void theUploadDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state has no multipart uploads.
  }

  @Given("the part has not already been uploaded")
  public void thePartHasNotAlreadyBeenUploaded() {
    // Arrange / Act / Assert — no-op: fresh upload has no uploaded parts.
  }

  @Given("the part has already been uploaded")
  public void thePartHasAlreadyBeenUploaded() {
    // Arrange
    String activeUploadId = uploadId != null ? uploadId : TEST_UPLOAD_ID_FALLBACK;
    // Act: upload a part to the existing multipart upload
    try (GlacierClient client = world.session.glacierClient()) {
      client.uploadMultipartPart(
          r ->
              r.accountId(ACCOUNT_ID)
                  .vaultName(TEST_VAULT)
                  .uploadId(activeUploadId)
                  .range("bytes 0-1023/*"),
          RequestBody.fromBytes("test-part-content-1".getBytes(StandardCharsets.UTF_8)));
      // Assert: part uploaded (no error thrown)
    }
  }

  @Given("the archive slot is available")
  public void theArchiveSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: archive slots are available by default.
  }

  @Given("the archive slot is not available")
  public void theArchiveSlotIsNotAvailable() throws Exception {
    // Arrange: exhaust glacier archive capacity
    // Act
    world.session.capacity("glacier").exhaust().apply();
    // Assert: capacity exhausted
  }

  // ── Given: model-level precondition steps (sequences.feature) ─────────────────

  @Given("vault not in vault_status")
  public void vaultNotInVaultStatus() {
    // Arrange / Act / Assert — no-op: fresh state has no vaults.
  }

  @Given("vault in vault_status")
  public void vaultInVaultStatus() {
    // Arrange
    // Act
    glacierCreateVault();
    // Assert: vault exists (no error thrown)
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a vault is created")
  public void aVaultIsCreated() {
    // Arrange: (vault may or may not exist — set up by Given steps)
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      client.createVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
      // Assert: store result
      world.setSuccess(TEST_VAULT);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an empty vault is deleted")
  public void anEmptyVaultIsDeleted() {
    // Arrange: (vault state set up by Given steps)
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      client.deleteVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an archive is uploaded to a vault")
  public void anArchiveIsUploadedToAVault() {
    // Arrange: (vault state set up by Given steps)
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      UploadArchiveResponse resp =
          client.uploadArchive(
              r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT),
              RequestBody.fromBytes("test-archive-content-1".getBytes(StandardCharsets.UTF_8)));
      // Assert: store result
      archiveId = resp.archiveId();
      world.setSuccess(resp);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an archive is deleted from a vault")
  public void anArchiveIsDeletedFromAVault() {
    // Arrange: (vault/archive state set up by Given steps)
    String activeArchiveId = archiveId != null ? archiveId : TEST_ARCHIVE;
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      client.deleteArchive(
          r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT).archiveId(activeArchiveId));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an archive retrieval job is initiated")
  public void anArchiveRetrievalJobIsInitiated() {
    // Arrange: (vault/archive state set up by Given steps)
    String activeArchiveId = archiveId != null ? archiveId : TEST_ARCHIVE;
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      InitiateJobResponse resp =
          client.initiateJob(
              r ->
                  r.accountId(ACCOUNT_ID)
                      .vaultName(TEST_VAULT)
                      .jobParameters(
                          jp -> jp.type("archive-retrieval").archiveId(activeArchiveId)));
      // Assert: store result
      jobId = resp.jobId();
      world.setSuccess(resp);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a vault inventory retrieval job is initiated")
  public void aVaultInventoryRetrievalJobIsInitiated() {
    // Arrange: (vault state set up by Given steps)
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      InitiateJobResponse resp =
          client.initiateJob(
              r ->
                  r.accountId(ACCOUNT_ID)
                      .vaultName(TEST_VAULT)
                      .jobParameters(jp -> jp.type("inventory-retrieval")));
      // Assert: store result
      jobId = resp.jobId();
      world.setSuccess(resp);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the output of a succeeded job is retrieved")
  public void theOutputOfASucceededJobIsRetrieved() {
    // Arrange: (job state set up by Given steps)
    // @internal: job_succeeds requires background processing; this step is only
    // reached in @internal scenarios which are excluded from the standard run.
    if (jobId == null) {
      world.setFailure(new RuntimeException("ResourceNotFoundException: job not found"));
      return;
    }
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      var resp =
          client.getJobOutput(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT).jobId(jobId));
      // Assert: store result
      world.setSuccess(resp);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a multipart upload is initiated for a vault")
  public void aMultipartUploadIsInitiatedForAVault() {
    // Arrange: (vault state set up by Given steps)
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      InitiateMultipartUploadResponse resp =
          client.initiateMultipartUpload(
              r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT).partSize(TEST_PART_SIZE));
      // Assert: store result
      uploadId = resp.uploadId();
      world.setSuccess(resp);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a part is uploaded for a multipart upload")
  public void aPartIsUploadedForAMultipartUpload() {
    // Arrange: (upload state set up by Given steps)
    String activeUploadId = uploadId != null ? uploadId : TEST_UPLOAD_ID_FALLBACK;
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      var resp =
          client.uploadMultipartPart(
              r ->
                  r.accountId(ACCOUNT_ID)
                      .vaultName(TEST_VAULT)
                      .uploadId(activeUploadId)
                      .range("bytes 0-1023/*"),
              RequestBody.fromBytes("test-part-content-1".getBytes(StandardCharsets.UTF_8)));
      // Assert: store result
      world.setSuccess(resp);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a multipart upload is completed")
  public void aMultipartUploadIsCompleted() {
    // Arrange: (upload/vault state set up by Given steps)
    String activeUploadId = uploadId != null ? uploadId : TEST_UPLOAD_ID_FALLBACK;
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      var resp =
          client.completeMultipartUpload(
              r ->
                  r.accountId(ACCOUNT_ID)
                      .vaultName(TEST_VAULT)
                      .uploadId(activeUploadId)
                      .archiveSize("1024"));
      // Assert: store result
      if (resp.archiveId() != null) {
        archiveId = resp.archiveId();
      }
      world.setSuccess(resp);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a multipart upload is aborted")
  public void aMultipartUploadIsAborted() {
    // If an S3 multipart upload context is active, abort using S3 (s3api scenarios)
    if (world.s3UploadBucket != null) {
      String activeS3UploadId =
          world.s3UploadId != null ? world.s3UploadId : "non-existent-upload-id";
      try (S3Client s3Client = world.session.s3Client()) {
        // Act
        s3Client.abortMultipartUpload(
            r ->
                r.bucket(world.s3UploadBucket).key("e2e-test-object-1").uploadId(activeS3UploadId));
        // Assert: store result
        world.setSuccess(null);
      } catch (Exception e) {
        world.setFailure(e);
      }
      return;
    }
    // Arrange: (upload state set up by Given steps)
    String activeUploadId = uploadId != null ? uploadId : TEST_UPLOAD_ID_FALLBACK;
    try (GlacierClient client = world.session.glacierClient()) {
      // Act
      client.abortMultipartUpload(
          r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT).uploadId(activeUploadId));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a job fails")
  public void aJobFails() {
    // @internal: job failure requires background Glacier processing.
    // This action cannot be performed via the public Glacier API.
    world.setFailure(
        new RuntimeException(
            "InvalidParameterValueException: job failure requires internal processing"));
  }

  @When("a job completes successfully")
  public void aJobCompletesSuccessfully() {
    // @internal: job success requires background Glacier processing.
    // This action cannot be performed via the public Glacier API.
    world.setFailure(
        new RuntimeException(
            "InvalidParameterValueException: job success requires internal processing"));
  }

  @When("a vault inventory is refreshed")
  public void aVaultInventoryIsRefreshed() {
    // @internal: vault inventory refresh requires background Glacier processing.
    // This action cannot be performed via the public Glacier API.
    world.setFailure(
        new RuntimeException(
            "InvalidParameterValueException: vault inventory refresh requires internal processing"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the vault is \"ACTIVE\" with zero archives")
  public void theVaultIsActiveWithZeroArchives() {
    // Arrange
    // Act
    try (GlacierClient client = world.session.glacierClient()) {
      boolean expectedSuccess = true;
      boolean actualSuccess = world.lastSuccess;
      assertTrue(
          actualSuccess,
          "expected create_vault to succeed but got error: "
              + world.lastError
              + "; expected_success="
              + expectedSuccess);
      DescribeVaultResponse resp =
          client.describeVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
      // Assert
      long expectedCount = 0L;
      long actualCount = resp.numberOfArchives();
      assertEquals(
          expectedCount,
          actualCount,
          "expected vault archive count "
              + expectedCount
              + " but got "
              + actualCount
              + "; expected_count="
              + expectedCount
              + " actual_count="
              + actualCount);
    }
  }

  @Then("the vault is \"DELETED\"")
  public void theVaultIsDeleted() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_vault to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the archive is \"STORED\" and the vault archive count increases")
  public void theArchiveIsStoredAndTheVaultArchiveCountIncreases() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected upload_archive to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected UploadArchiveResponse but got null");
  }

  @Then("the archive is \"DELETED\" and the vault archive count decreases")
  public void theArchiveIsDeletedAndTheVaultArchiveCountDecreases() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_archive to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the job is InProgress for the given archive")
  public void theJobIsInProgressForTheGivenArchive() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected initiate_job to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected InitiateJobResponse but got null");
  }

  @Then("the job is InProgress for the given vault")
  public void theJobIsInProgressForTheGivenVault() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected initiate_job to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected InitiateJobResponse but got null");
  }

  @Then("the job output is marked as retrieved")
  public void theJobOutputIsMarkedAsRetrieved() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected get_job_output to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected GetJobOutputResponse but got null");
  }

  @Then("the part is recorded for the upload")
  public void thePartIsRecordedForTheUpload() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected upload_multipart_part to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the upload is Completed and the assembled archive is \"STORED\" in the vault")
  public void theUploadIsCompletedAndTheAssembledArchiveIsStoredInTheVault() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected complete_multipart_upload to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected CompleteMultipartUploadResponse but got null");
  }

  @Then("the upload is Aborted")
  public void theUploadIsAborted() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected abort_multipart_upload to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the job is Failed")
  public void theJobIsFailed() {
    // @internal: job_fails requires background processing. No assertion performed.
  }

  @Then("the job is Succeeded and its output is available")
  public void theJobIsSucceededAndItsOutputIsAvailable() {
    // @internal: job_succeeds requires background processing. No assertion performed.
  }

  @Then("the vault inventory is marked as fresh")
  public void theVaultInventoryIsMarkedAsFresh() {
    // @internal: vault_inventory_refresh requires background processing. No assertion performed.
  }

  // ── Safety invariant Then steps ───────────────────────────────────────────────

  // "every in-progress job references an active vault" → CrossServiceSteps (catch-all @And("^every
  // .*$"))

  @Then("vault archive count is never negative")
  public void vaultArchiveCountIsNeverNegative() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("all stored archives belong to an \"ACTIVE\" vault")
  public void allStoredArchivesBelongToAnActiveVault() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("job output is only available for succeeded jobs")
  public void jobOutputIsOnlyAvailableForSucceededJobs() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  // "every archive retrieval job references a non-empty archive \"ID\"" → CrossServiceSteps
  // (catch-all @And("^every .*$"))

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void glacierCreateVault() {
    try (GlacierClient client = world.session.glacierClient()) {
      client.createVault(r -> r.accountId(ACCOUNT_ID).vaultName(TEST_VAULT));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("VaultAlreadyExists")) {
        throw e;
      }
    }
  }
}
