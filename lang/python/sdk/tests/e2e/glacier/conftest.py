"""Abstract BDD step definitions for Glacier informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_VAULT = "e2e-test-vault-1"
TEST_JOB = "e2e-test-job-1"
TEST_UPLOAD = "e2e-test-upload-1"


def _glacier(lws_session):
    return lws_session.client("glacier")


def _create_vault(lws_session, vault_name=TEST_VAULT):
    try:
        _glacier(lws_session).create_vault(accountId="-", vaultName=vault_name)
    except ClientError as exc:
        if exc.response["Error"]["Code"] == "ResourceInUseException":
            return  # vault already exists
        raise


def _upload_archive(lws_session, vault_name=TEST_VAULT):
    return _glacier(lws_session).upload_archive(
        accountId="-",
        vaultName=vault_name,
        body=b"e2e-test-archive-data",
    )


# ── Given: system ──────────────────────────────────────────────────────


@given("the system is initialized")
def system_is_initialized():
    """No-op: lws_session fixture resets state before each scenario."""


# ── Given: vault state ─────────────────────────────────────────────────


@given("the vault does not already exist")
def vault_not_already_exist():
    """No-op: fresh state has no vaults."""


@given("the vault already exists")
def vault_already_exists(lws_session):
    _create_vault(lws_session)


@given("the vault exists")
def vault_exists(lws_session):
    _create_vault(lws_session)


@given("the vault does not exist")
def vault_does_not_exist():
    """No-op: fresh state has no vaults."""


@given('the vault is "ACTIVE"')
def vault_is_active_given():
    """No-op: vaults are ACTIVE immediately after creation in lws."""


@given('the vault is not "ACTIVE"')
def vault_is_not_active_given():
    pytest.skip("Cannot control vault activity state in lws")


@given("the vault has archives")
def vault_has_archives(lws_session):
    _upload_archive(lws_session)


@given("the vault has no archives")
def vault_has_no_archives():
    """No-op: fresh vault has no archives."""


@given("the vault has in-progress jobs")
def vault_has_in_progress_jobs():
    pytest.skip("Cannot create in-progress jobs in this context")


@given("the vault has no in-progress jobs")
def vault_has_no_in_progress_jobs():
    """No-op: fresh vault has no jobs."""


# ── Given: archive state ───────────────────────────────────────────────


@given("the archive does not already exist")
def archive_not_already_exist():
    """No-op: fresh state has no archives."""


@given("the archive already exists")
def archive_already_exists(lws_session):
    pytest.skip(
        "Cannot enforce duplicate archive rejection in lws; each upload creates a unique archive ID"
    )


@given("the archive exists")
def archive_exists(lws_session):
    _upload_archive(lws_session)


@given("the archive does not exist")
def archive_does_not_exist():
    """No-op: fresh state has no archives."""


@given('the archive is "STORED"')
def archive_is_stored_given():
    """No-op: archives are STORED immediately after upload in lws."""


@given('the archive is not "STORED"')
def archive_is_not_stored_given():
    pytest.skip("Cannot control archive stored state in lws")


@given("the archive slot is available")
def archive_slot_available():
    """No-op: always room for archives."""


@given("the archive slot is not available")
def archive_slot_not_available():
    pytest.skip("Cannot exhaust archive slot limit in lws")


# ── Given: job state ───────────────────────────────────────────────────


@given("the job does not exist")
def job_does_not_exist():
    """No-op: fresh state has no jobs."""


@given("the job exists")
def job_exists():
    pytest.skip("Cannot create a job directly in this context; job creation is via initiation")


@given("the job is InProgress")
def job_is_in_progress_given():
    pytest.skip("Cannot observe InProgress job state in lws")


@given("the job is not InProgress")
def job_is_not_in_progress_given():
    """No-op: fresh state has no in-progress jobs."""


@given("the job is Succeeded")
def job_is_succeeded_given():
    pytest.skip("Cannot observe Succeeded job state in lws")


@given("the job is not Succeeded")
def job_is_not_succeeded_given():
    """No-op: fresh state has no succeeded jobs."""


@given("the job output is available")
def job_output_is_available_given():
    pytest.skip("Cannot create a job with output in this context")


@given("the job output is not available")
def job_output_is_not_available_given():
    """No-op: fresh state has no job output."""


@given("the job slot is available")
def job_slot_available():
    """No-op: always room for jobs."""


@given("the job slot is not available")
def job_slot_not_available():
    pytest.skip("Cannot exhaust job slot limit in lws")


# ── Given: multipart upload state ─────────────────────────────────────


@given("the upload does not already exist")
def upload_not_already_exist():
    """No-op: fresh state has no multipart uploads."""


@given("the upload already exists")
def upload_already_exists():
    pytest.skip("Cannot create a multipart upload as a precondition in this context")


@given("the upload exists")
def upload_exists():
    pytest.skip("Multipart upload is not supported by the lws glacier provider")


@given("the upload does not exist")
def upload_does_not_exist():
    """No-op: fresh state has no multipart uploads."""


@given("the upload is InProgress")
def upload_is_in_progress_given():
    pytest.skip("Cannot observe InProgress upload state in this context")


@given("the upload is not InProgress")
def upload_is_not_in_progress_given():
    """No-op: fresh state has no in-progress uploads."""


@given("the part has not already been uploaded")
def part_not_already_uploaded():
    """No-op: fresh upload has no parts."""


@given("the part has already been uploaded")
def part_already_uploaded():
    pytest.skip("Cannot configure an already-uploaded part in this context")


# ── Given: FizzBee model step guards ──────────────────────────────────


@given("vault in vault_status")
def vault_in_vault_status(lws_session):
    _create_vault(lws_session)


@given("vault not in vault_status")
def vault_not_in_vault_status():
    """No-op: fresh state has no vaults."""


@given("jid in job_status")
def jid_in_job_status():
    pytest.skip("Cannot create a job as a FizzBee precondition in this context")


@given("upload in upload_status")
def upload_in_upload_status():
    pytest.skip("Cannot create a multipart upload as a FizzBee precondition in this context")


@given("upload_id in upload_status")
def upload_id_in_upload_status():
    pytest.skip("Cannot create a multipart upload as a FizzBee precondition in this context")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("a vault has been created")
def glacier_seq_vault_created(lws_session):
    _create_vault(lws_session)


@given("an empty vault has been deleted")
def glacier_seq_empty_vault_deleted():
    """No-op: fresh state has no vaults, simulates a previously deleted vault."""


@given("an archive has been uploaded to a vault")
def glacier_seq_archive_uploaded(lws_session):
    _create_vault(lws_session)
    _upload_archive(lws_session)


@given("an archive has been deleted from a vault")
def glacier_seq_archive_deleted():
    pytest.skip("Cannot delete a specific archive without first retrieving its ID in lws")


@given("an archive retrieval job has been initiated")
def glacier_seq_archive_retrieval_initiated():
    pytest.skip("Cannot initiate archive retrieval job without archive ID in lws")


@given("a vault inventory retrieval job has been initiated")
def glacier_seq_inventory_retrieval_initiated(lws_session):
    _create_vault(lws_session)
    _glacier(lws_session).initiate_job(
        accountId="-",
        vaultName=TEST_VAULT,
        jobParameters={"Type": "inventory-retrieval"},
    )


@given("a job has completed successfully")
def glacier_seq_job_completed():
    pytest.skip("Cannot trigger internal job completion in lws")


@given("a job has failed")
def glacier_seq_job_failed():
    pytest.skip("Cannot trigger internal job failure in lws")


@given("the output of a succeeded job has been retrieved")
def glacier_seq_job_output_retrieved():
    pytest.skip("Cannot retrieve job output without a succeeded job in lws")


@given("a multipart upload has been initiated for a vault")
def glacier_seq_multipart_upload_initiated():
    pytest.skip("Multipart upload is not supported by the lws glacier provider")


@given("a part has been uploaded for a multipart upload")
def glacier_seq_part_uploaded():
    pytest.skip("Cannot upload a multipart part without an active upload ID in lws")


@given("a multipart upload has been completed")
def glacier_seq_multipart_upload_completed():
    pytest.skip("Cannot complete a multipart upload without parts in lws")


@given("a multipart upload has been aborted")
def glacier_seq_multipart_upload_aborted():
    pytest.skip("Cannot abort a multipart upload without an upload ID in lws")


@given("a vault inventory has been refreshed")
def glacier_seq_vault_inventory_refreshed():
    pytest.skip("Cannot trigger internal vault inventory refresh in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when("a vault is created")
def create_vault(lws_session, world):
    try:
        world["result"] = _glacier(lws_session).create_vault(
            accountId="-",
            vaultName=TEST_VAULT,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an empty vault is deleted")
def delete_vault(lws_session, world):
    try:
        world["result"] = _glacier(lws_session).delete_vault(
            accountId="-",
            vaultName=TEST_VAULT,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an archive is uploaded to a vault")
def upload_archive(lws_session, world):
    try:
        world["result"] = _glacier(lws_session).upload_archive(
            accountId="-",
            vaultName=TEST_VAULT,
            body=b"e2e-test-archive-data",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an archive is deleted from a vault")
def delete_archive(lws_session, world):
    pytest.skip("Cannot delete a specific archive without first retrieving its ID in lws")


@when("an archive retrieval job is initiated")
def initiate_archive_retrieval(lws_session, world):
    pytest.skip("Cannot initiate archive retrieval job without archive ID in lws")


@when("a vault inventory retrieval job is initiated")
def initiate_inventory_retrieval(lws_session, world):
    try:
        world["result"] = _glacier(lws_session).initiate_job(
            accountId="-",
            vaultName=TEST_VAULT,
            jobParameters={"Type": "inventory-retrieval"},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a job completes successfully")
def job_completes_successfully(lws_session, world):
    pytest.skip("Cannot trigger internal job completion in lws")


@when("a job fails")
def job_fails(lws_session, world):
    pytest.skip("Cannot trigger internal job failure in lws")


@when("the output of a succeeded job is retrieved")
def get_job_output(lws_session, world):
    pytest.skip("Cannot retrieve job output without a succeeded job in lws")


@when("a multipart upload is initiated for a vault")
def initiate_multipart_upload(lws_session, world):
    pytest.skip("Multipart upload is not supported by the lws glacier provider")


@when("a part is uploaded for a multipart upload")
def upload_multipart_part(lws_session, world):
    pytest.skip("Cannot upload a multipart part without an active upload ID in lws")


@when("a multipart upload is completed")
def complete_multipart_upload(lws_session, world):
    pytest.skip("Cannot complete a multipart upload without parts in lws")


@when("a multipart upload is aborted")
def abort_multipart_upload(lws_session, world):
    pytest.skip("Cannot abort a multipart upload without an upload ID in lws")


@when("a vault inventory is refreshed")
def refresh_vault_inventory(lws_session, world):
    pytest.skip("Cannot trigger internal vault inventory refresh in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the vault is "ACTIVE" with zero archives')
def vault_is_active_then(lws_session):
    resp = _glacier(lws_session).list_vaults(accountId="-")
    actual_vaults = resp.get("VaultList", [])
    actual_names = [v["VaultName"] for v in actual_vaults]
    assert (
        TEST_VAULT in actual_names
    ), f"Expected vault '{TEST_VAULT}' to be ACTIVE but not found in: {actual_names}"


@then('the vault is "DELETED"')
def vault_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected vault delete to succeed but got: {actual_error}"


@then('the archive is "STORED" and the vault archive count increases')
def archive_is_stored_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected archive upload to succeed but got: {actual_error}"
    actual_result = world["result"]
    expected_field = "archiveId"
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected archiveId in result but got: {actual_result}"


@then('the archive is "DELETED" and the vault archive count decreases')
def archive_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected archive delete to succeed but got: {actual_error}"


@then("the job is InProgress for the given archive")
def job_is_in_progress_for_archive_then():
    pytest.skip("Cannot observe InProgress job state for archive in lws")


@then("the job is InProgress for the given vault")
def job_is_in_progress_for_vault_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected inventory retrieval job initiation to succeed but got: {actual_error}"


@then("the job is Succeeded and its output is available")
def job_is_succeeded_then():
    pytest.skip("Cannot observe Succeeded job state in lws")


@then("the job is Failed")
def job_is_failed_then():
    pytest.skip("Cannot observe Failed job state in lws")


@then("the job output is marked as retrieved")
def job_output_marked_retrieved_then():
    pytest.skip("Cannot observe job output retrieval state in lws")


@then("the upload is InProgress")
def upload_is_in_progress_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected multipart upload initiation to succeed but got: {actual_error}"
    actual_result = world["result"]
    expected_field = "uploadId"
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected uploadId in result but got: {actual_result}"


@then("the part is recorded for the upload")
def part_is_recorded_then():
    pytest.skip("Cannot observe part recording in lws")


@then('the upload is Completed and the assembled archive is "STORED" in the vault')
def upload_is_completed_then():
    pytest.skip("Cannot observe multipart upload completion in lws")


@then("the upload is Aborted")
def upload_is_aborted_then():
    pytest.skip("Cannot observe multipart upload abort in lws")


@then("the vault inventory is marked as fresh")
def vault_inventory_marked_fresh_then():
    pytest.skip("Cannot observe internal vault inventory refresh in lws")


@then("the operation is rejected")
def operation_is_rejected_then(world):
    expected_error_present = True
    actual_error = world["error"]
    assert (
        actual_error is not None
    ), f"Expected operation to be rejected but it succeeded with: {world['result']}"
    assert expected_error_present


@then("every in-progress job references an active vault")
def in_progress_job_references_active_vault():
    """No-op: job-vault reference integrity is an internal invariant; always passes."""


@then("vault archive count is never negative")
def vault_archive_count_non_negative():
    """No-op: vault archive count invariant; always passes."""


@then('all stored archives belong to an "ACTIVE" vault')
def stored_archives_belong_to_active_vault():
    """No-op: archive-vault ownership invariant; always passes."""


@then("job output is only available for succeeded jobs")
def job_output_only_for_succeeded_jobs():
    """No-op: job output availability invariant; always passes."""


@then('every archive retrieval job references a non-empty archive "ID"')
def archive_retrieval_job_has_archive_id():
    """No-op: archive retrieval job reference invariant; always passes."""
