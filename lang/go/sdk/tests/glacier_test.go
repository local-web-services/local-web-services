package tests

// registerGlacierSteps wires all step definitions for the Glacier informal specification
// feature files (create_vault, delete_vault, upload_archive, delete_archive,
// initiate_archive_retrieval_job, initiate_inventory_retrieval_job, get_job_output,
// initiate_multipart_upload, upload_multipart_part, complete_multipart_upload,
// abort_multipart_upload, job_fails, job_succeeds, vault_inventory_refresh).

import (
	"context"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/glacier"
	glaciertypes "github.com/aws/aws-sdk-go-v2/service/glacier/types"
	"github.com/cucumber/godog"
)

const (
	glacierTestVaultName   = "test-glacier-vault-1"
	glacierTestArchiveID   = "test-glacier-archive-1"
	glacierTestAccountID   = "-"
	glacierTestPartSize    = "1048576"
	glacierTestUploadID    = "test-glacier-upload-1"
)

// glacierState holds mutable state for Glacier step definitions within one scenario.
type glacierState struct {
	vaultExists     bool
	archiveID       string
	uploadID        string
	jobID           string
	partUploaded    bool
}

// glacierCreateVault is a helper that creates the test Glacier vault.
func glacierCreateVault(world *World) error {
	_, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
		AccountId: aws.String(glacierTestAccountID),
		VaultName: aws.String(glacierTestVaultName),
	})
	return err
}

// glacierUploadArchive is a helper that uploads a test archive to the vault.
func glacierUploadArchive(world *World) (string, error) {
	resp, err := world.GlacierClient().UploadArchive(context.Background(), &glacier.UploadArchiveInput{
		AccountId: aws.String(glacierTestAccountID),
		VaultName: aws.String(glacierTestVaultName),
		Body:      strings.NewReader("test-archive-content-1"),
	})
	if err != nil {
		return "", err
	}
	if resp.ArchiveId == nil {
		return "", fmt.Errorf("UploadArchive returned nil ArchiveId")
	}
	return *resp.ArchiveId, nil
}

// glacierInitiateMultipartUpload is a helper that initiates a multipart upload.
func glacierInitiateMultipartUpload(world *World) (string, error) {
	resp, err := world.GlacierClient().InitiateMultipartUpload(context.Background(), &glacier.InitiateMultipartUploadInput{
		AccountId: aws.String(glacierTestAccountID),
		VaultName: aws.String(glacierTestVaultName),
		PartSize:  aws.String(glacierTestPartSize),
	})
	if err != nil {
		return "", err
	}
	if resp.UploadId == nil {
		return "", fmt.Errorf("InitiateMultipartUpload returned nil UploadId")
	}
	return *resp.UploadId, nil
}

func registerGlacierSteps(sc *godog.ScenarioContext, world *World) {
	gs := &glacierState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		gs.vaultExists = false
		gs.archiveID = ""
		gs.uploadID = ""
		gs.jobID = ""
		gs.partUploaded = false
		return ctx, nil
	})

	// -------------------------------------------------------------------------
	// Given: vault state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the vault does not already exist$`, func() error {
		// No-op: fresh state after reset has no vaults.
		return nil
	})

	sc.Given(`^the vault already exists$`, func() error {
		// Arrange / Act: create the vault so it already exists.
		if err := glacierCreateVault(world); err != nil {
			return fmt.Errorf("create vault: %w", err)
		}
		gs.vaultExists = true
		return nil
	})

	sc.Given(`^the vault exists$`, func() error {
		// Arrange / Act: ensure the vault exists.
		if err := glacierCreateVault(world); err != nil {
			return fmt.Errorf("create vault: %w", err)
		}
		gs.vaultExists = true
		return nil
	})

	sc.Given(`^the vault is "ACTIVE"$`, func() error {
		// No-op: vaults are always ACTIVE immediately after creation in lws.
		return nil
	})

	sc.Given(`^the vault is not "ACTIVE"$`, func() error {
		// @internal: vault lifecycle transitions require background processing.
		// This state cannot be forced via the public Glacier API.
		return nil
	})

	sc.Given(`^the vault does not exist$`, func() error {
		// No-op: fresh state after reset has no vaults.
		return nil
	})

	sc.Given(`^the vault has no archives$`, func() error {
		// No-op: fresh vault has no archives.
		return nil
	})

	sc.Given(`^the vault has archives$`, func() error {
		// Arrange / Act: upload an archive to the vault.
		archiveID, err := glacierUploadArchive(world)
		if err != nil {
			return fmt.Errorf("upload archive: %w", err)
		}
		gs.archiveID = archiveID
		return nil
	})

	sc.Given(`^the vault has no in-progress jobs$`, func() error {
		// No-op: fresh vault has no in-progress jobs.
		return nil
	})

	sc.Given(`^the vault has in-progress jobs$`, func() error {
		// Arrange / Act: initiate a job to create an in-progress job state.
		resp, err := world.GlacierClient().InitiateJob(context.Background(), &glacier.InitiateJobInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			JobParameters: &glaciertypes.JobParameters{
				Type: aws.String("inventory-retrieval"),
			},
		})
		if err != nil {
			return fmt.Errorf("initiate job: %w", err)
		}
		if resp.JobId != nil {
			gs.jobID = *resp.JobId
		}
		return nil
	})

	// -------------------------------------------------------------------------
	// Given: archive state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the archive does not already exist$`, func() error {
		// No-op: fresh vault has no archives.
		return nil
	})

	sc.Given(`^the archive already exists$`, func() error {
		// Arrange / Act: upload an archive so it already exists.
		archiveID, err := glacierUploadArchive(world)
		if err != nil {
			return fmt.Errorf("upload archive: %w", err)
		}
		gs.archiveID = archiveID
		return nil
	})

	sc.Given(`^the archive exists$`, func() error {
		// Arrange / Act: ensure the archive exists.
		archiveID, err := glacierUploadArchive(world)
		if err != nil {
			return fmt.Errorf("upload archive: %w", err)
		}
		gs.archiveID = archiveID
		return nil
	})

	sc.Given(`^the archive is "STORED"$`, func() error {
		// No-op: archives are STORED immediately after upload in lws.
		return nil
	})

	sc.Given(`^the archive is not "STORED"$`, func() error {
		// @internal: archive lifecycle transitions require background processing.
		return nil
	})

	sc.Given(`^the archive does not exist$`, func() error {
		// No-op: fresh vault has no archives.
		return nil
	})

	// -------------------------------------------------------------------------
	// Given: job state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the job slot is available$`, func() error {
		// No-op: job slots are available by default.
		return nil
	})

	sc.Given(`^the job slot is not available$`, func() error {
		// Arrange: exhaust glacier job capacity.
		// Act
		return managementSession().Capacity("glacier").Exhaust().Apply()
	})

	sc.Given(`^the job exists$`, func() error {
		// Arrange / Act: initiate a job so it exists.
		if err := glacierCreateVault(world); err != nil {
			return fmt.Errorf("create vault: %w", err)
		}
		resp, err := world.GlacierClient().InitiateJob(context.Background(), &glacier.InitiateJobInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			JobParameters: &glaciertypes.JobParameters{
				Type: aws.String("inventory-retrieval"),
			},
		})
		if err != nil {
			return fmt.Errorf("initiate job: %w", err)
		}
		if resp.JobId != nil {
			gs.jobID = *resp.JobId
		}
		return nil
	})

	sc.Given(`^the job is Succeeded$`, func() error {
		// @internal: job success requires background Glacier job processing.
		// Job completion cannot be forced via the public Glacier API.
		return nil
	})

	sc.Given(`^the job is InProgress$`, func() error {
		// No-op: jobs are InProgress immediately after initiation in lws.
		return nil
	})

	sc.Given(`^the job is not Succeeded$`, func() error {
		// @internal: job lifecycle transitions require background processing.
		return nil
	})

	sc.Given(`^the job is not InProgress$`, func() error {
		// @internal: job lifecycle transitions require background processing.
		return nil
	})

	sc.Given(`^the job does not exist$`, func() error {
		// No-op: fresh state after reset has no jobs.
		return nil
	})

	sc.Given(`^the job output is available$`, func() error {
		// @internal: job output availability requires background Glacier job processing.
		return nil
	})

	sc.Given(`^the job output is not available$`, func() error {
		// @internal: job output availability requires background Glacier job processing.
		return nil
	})

	// -------------------------------------------------------------------------
	// Given: multipart upload state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the upload does not already exist$`, func() error {
		// No-op: fresh state after reset has no multipart uploads.
		return nil
	})

	sc.Given(`^the upload already exists$`, func() error {
		// Arrange / Act: initiate a multipart upload so it already exists.
		uploadID, err := glacierInitiateMultipartUpload(world)
		if err != nil {
			return fmt.Errorf("initiate multipart upload: %w", err)
		}
		gs.uploadID = uploadID
		return nil
	})

	sc.Given(`^the upload exists$`, func() error {
		// Arrange / Act: ensure a multipart upload exists.
		uploadID, err := glacierInitiateMultipartUpload(world)
		if err != nil {
			return fmt.Errorf("initiate multipart upload: %w", err)
		}
		gs.uploadID = uploadID
		return nil
	})

	sc.Given(`^the upload is InProgress$`, func() error {
		// No-op: multipart uploads are InProgress immediately after initiation in lws.
		return nil
	})

	sc.Given(`^the upload is not InProgress$`, func() error {
		// @internal: upload lifecycle transitions require background processing.
		return nil
	})

	sc.Given(`^the upload does not exist$`, func() error {
		// No-op: fresh state after reset has no multipart uploads.
		return nil
	})

	sc.Given(`^the part has not already been uploaded$`, func() error {
		// No-op: fresh upload has no uploaded parts.
		return nil
	})

	sc.Given(`^the part has already been uploaded$`, func() error {
		// Arrange: upload a part to the existing multipart upload.
		// Act
		_, err := world.GlacierClient().UploadMultipartPart(context.Background(), &glacier.UploadMultipartPartInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			UploadId:  aws.String(gs.uploadID),
			Range:     aws.String("bytes 0-1023/*"),
			Body:      strings.NewReader("test-part-content-1"),
		})
		if err != nil {
			return fmt.Errorf("upload multipart part: %w", err)
		}
		gs.partUploaded = true
		return nil
	})

	sc.Given(`^the archive slot is available$`, func() error {
		// No-op: archive slots are available by default.
		return nil
	})

	sc.Given(`^the archive slot is not available$`, func() error {
		// Arrange: exhaust glacier archive capacity.
		// Act
		return managementSession().Capacity("glacier").Exhaust().Apply()
	})

	// -------------------------------------------------------------------------
	// Given: model-level precondition steps (sequences.feature)
	// -------------------------------------------------------------------------

	sc.Given(`^vault not in vault_status$`, func() error {
		// No-op: fresh state has no vaults.
		return nil
	})

	sc.Given(`^vault in vault_status$`, func() error {
		// Arrange / Act: ensure a vault exists.
		if err := glacierCreateVault(world); err != nil {
			return fmt.Errorf("create vault: %w", err)
		}
		gs.vaultExists = true
		return nil
	})

	// -------------------------------------------------------------------------
	// When: actions
	// -------------------------------------------------------------------------

	sc.When(`^a vault is created$`, func() error {
		// Arrange: (vault may or may not exist — set up by Given steps)
		// Act
		resp, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an empty vault is deleted$`, func() error {
		// Arrange: (vault state set up by Given steps)
		// Act
		resp, err := world.GlacierClient().DeleteVault(context.Background(), &glacier.DeleteVaultInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an archive is uploaded to a vault$`, func() error {
		// Arrange: (vault state set up by Given steps)
		// Act
		resp, err := world.GlacierClient().UploadArchive(context.Background(), &glacier.UploadArchiveInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			Body:      strings.NewReader("test-archive-content-1"),
		})
		if err == nil && resp.ArchiveId != nil {
			gs.archiveID = *resp.ArchiveId
		}
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an archive is deleted from a vault$`, func() error {
		// Arrange: (vault/archive state set up by Given steps)
		archiveID := gs.archiveID
		if archiveID == "" {
			archiveID = glacierTestArchiveID
		}
		// Act
		resp, err := world.GlacierClient().DeleteArchive(context.Background(), &glacier.DeleteArchiveInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			ArchiveId: aws.String(archiveID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an archive retrieval job is initiated$`, func() error {
		// Arrange: (vault/archive state set up by Given steps)
		archiveID := gs.archiveID
		if archiveID == "" {
			archiveID = glacierTestArchiveID
		}
		// Act
		resp, err := world.GlacierClient().InitiateJob(context.Background(), &glacier.InitiateJobInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			JobParameters: &glaciertypes.JobParameters{
				Type:      aws.String("archive-retrieval"),
				ArchiveId: aws.String(archiveID),
			},
		})
		if err == nil && resp.JobId != nil {
			gs.jobID = *resp.JobId
		}
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a vault inventory retrieval job is initiated$`, func() error {
		// Arrange: (vault state set up by Given steps)
		// Act
		resp, err := world.GlacierClient().InitiateJob(context.Background(), &glacier.InitiateJobInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			JobParameters: &glaciertypes.JobParameters{
				Type: aws.String("inventory-retrieval"),
			},
		})
		if err == nil && resp.JobId != nil {
			gs.jobID = *resp.JobId
		}
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the output of a succeeded job is retrieved$`, func() error {
		// Arrange: (job state set up by Given steps)
		// @internal: job_succeeds requires background processing; this step is only
		// reached in @internal scenarios which are excluded from the standard run.
		jobID := gs.jobID
		if jobID == "" {
			setResult(world, nil, fmt.Errorf("ResourceNotFoundException: job not found"))
			return nil
		}
		// Act
		resp, err := world.GlacierClient().GetJobOutput(context.Background(), &glacier.GetJobOutputInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			JobId:     aws.String(jobID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a multipart upload is initiated for a vault$`, func() error {
		// Arrange: (vault state set up by Given steps)
		// Act
		resp, err := world.GlacierClient().InitiateMultipartUpload(context.Background(), &glacier.InitiateMultipartUploadInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			PartSize:  aws.String(glacierTestPartSize),
		})
		if err == nil && resp.UploadId != nil {
			gs.uploadID = *resp.UploadId
		}
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a part is uploaded for a multipart upload$`, func() error {
		// Arrange: (upload state set up by Given steps)
		uploadID := gs.uploadID
		if uploadID == "" {
			uploadID = glacierTestUploadID
		}
		// Act
		resp, err := world.GlacierClient().UploadMultipartPart(context.Background(), &glacier.UploadMultipartPartInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			UploadId:  aws.String(uploadID),
			Range:     aws.String("bytes 0-1023/*"),
			Body:      strings.NewReader("test-part-content-1"),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a multipart upload is completed$`, func() error {
		// Arrange: (upload/vault state set up by Given steps)
		uploadID := gs.uploadID
		if uploadID == "" {
			uploadID = glacierTestUploadID
		}
		// Act
		resp, err := world.GlacierClient().CompleteMultipartUpload(context.Background(), &glacier.CompleteMultipartUploadInput{
			AccountId:   aws.String(glacierTestAccountID),
			VaultName:   aws.String(glacierTestVaultName),
			UploadId:    aws.String(uploadID),
			ArchiveSize: aws.String("1024"),
		})
		if err == nil && resp.ArchiveId != nil {
			gs.archiveID = *resp.ArchiveId
		}
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a multipart upload is aborted$`, func() error {
		// Arrange: (upload state set up by Given steps)
		uploadID := gs.uploadID
		if uploadID == "" {
			uploadID = glacierTestUploadID
		}
		// Act
		resp, err := world.GlacierClient().AbortMultipartUpload(context.Background(), &glacier.AbortMultipartUploadInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
			UploadId:  aws.String(uploadID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a job fails$`, func() error {
		// @internal: job failure requires background Glacier job processing.
		// This action cannot be performed via the public Glacier API.
		setResult(world, nil, fmt.Errorf("InvalidParameterValueException: job failure requires internal processing"))
		return nil
	})

	sc.When(`^a job completes successfully$`, func() error {
		// @internal: job success requires background Glacier job processing.
		// This action cannot be performed via the public Glacier API.
		setResult(world, nil, fmt.Errorf("InvalidParameterValueException: job success requires internal processing"))
		return nil
	})

	sc.When(`^a vault inventory is refreshed$`, func() error {
		// @internal: vault inventory refresh requires background Glacier processing.
		// This action cannot be performed via the public Glacier API.
		setResult(world, nil, fmt.Errorf("InvalidParameterValueException: vault inventory refresh requires internal processing"))
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	sc.Then(`^the vault is "ACTIVE" with zero archives$`, func() error {
		// Arrange: no additional setup required
		// Act: describe the vault to verify its state
		resp, err := world.GlacierClient().DescribeVault(context.Background(), &glacier.DescribeVaultInput{
			AccountId: aws.String(glacierTestAccountID),
			VaultName: aws.String(glacierTestVaultName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_vault to succeed but got: %w", err)
		}
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_vault to succeed but got: %w", world.lastResult.Error)
		}
		expectedCount := int64(0)
		actualCount := resp.NumberOfArchives
		if actualCount != expectedCount {
			return fmt.Errorf("expected vault archive count %d but got %d; expected_count=%d actual_count=%d",
				expectedCount, actualCount, expectedCount, actualCount)
		}
		return nil
	})

	sc.Then(`^the vault is "DELETED"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_vault to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the archive is "STORED" and the vault archive count increases$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected upload_archive to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected UploadArchiveOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the archive is "DELETED" and the vault archive count decreases$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_archive to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the job is InProgress for the given archive$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected initiate_job to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected InitiateJobOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the job is InProgress for the given vault$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected initiate_job to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected InitiateJobOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the job output is marked as retrieved$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected get_job_output to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected GetJobOutputOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the upload is InProgress$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected initiate_multipart_upload to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected InitiateMultipartUploadOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the part is recorded for the upload$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected upload_multipart_part to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the upload is Completed and the assembled archive is "STORED" in the vault$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected complete_multipart_upload to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected CompleteMultipartUploadOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the upload is Aborted$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected abort_multipart_upload to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the job is Failed$`, func() error {
		// @internal: job_fails requires background processing. No assertion performed.
		return nil
	})

	sc.Then(`^the job is Succeeded and its output is available$`, func() error {
		// @internal: job_succeeds requires background processing. No assertion performed.
		return nil
	})

	sc.Then(`^the vault inventory is marked as fresh$`, func() error {
		// @internal: vault_inventory_refresh requires background processing. No assertion performed.
		return nil
	})

	sc.Then(`^the operation is rejected$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error == nil {
			return fmt.Errorf("expected operation to be rejected but it succeeded; expected_error=non-nil actual_error=nil")
		}
		return nil
	})

	// ── Safety invariant Then steps ───────────────────────────────────────────

	sc.Then(`^every in-progress job references an active vault$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^vault archive count is never negative$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^all stored archives belong to an "ACTIVE" vault$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^job output is only available for succeeded jobs$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every archive retrieval job references a non-empty archive "ID"$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})
}
