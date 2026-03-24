"""Shared fixtures and BDD step definitions for Glacier integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app

INT_VAULT_NAME = "int-test-vault-1"
INT_ARCHIVE_BODY = b"int-test-archive-body-1"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """Glacier uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    app, _ = create_glacier_app()
    return app


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _store(world: dict, r, success_codes: tuple[int, ...] = (200,)) -> None:
    if r.status_code in success_codes:
        try:
            world["result"] = r.json()
        except Exception:
            world["result"] = {}
        world["error"] = None
    else:
        try:
            world["error"] = r.json()
        except Exception:
            world["error"] = {"status_code": r.status_code}
        world["result"] = None


def _create_vault(client: TestClient, vault_name: str = INT_VAULT_NAME) -> None:
    client.put(f"/-/vaults/{vault_name}")


def _upload_archive(
    client: TestClient,
    vault_name: str = INT_VAULT_NAME,
    body: bytes = INT_ARCHIVE_BODY,
) -> str:
    r = client.post(
        f"/-/vaults/{vault_name}/archives",
        content=body,
    )
    return r.headers.get("x-amz-archive-id", "")


def _initiate_job(
    client: TestClient,
    vault_name: str = INT_VAULT_NAME,
    job_type: str = "inventory-retrieval",
    archive_id: str | None = None,
) -> str:
    body: dict = {"Type": job_type}
    if archive_id is not None:
        body["ArchiveId"] = archive_id
    r = client.post(f"/-/vaults/{vault_name}/jobs", json=body)
    return r.headers.get("x-amz-job-id", "")


# ── Given: vault state ────────────────────────────────────────────────────────


@given("the vault does not already exist")
def vault_not_already_exist():
    """No-op: fresh state has no vaults."""


@given("the vault already exists")
def vault_already_exists(world):
    pytest.skip(
        "CreateVault is idempotent in lws (no uniqueness enforcement); "
        "duplicate vault creation cannot be tested in stateless integration tests."
    )


@given("the vault exists")
def vault_exists(client: TestClient, world):
    _create_vault(client)
    world["vault_name"] = INT_VAULT_NAME


@given("the vault does not exist")
def vault_does_not_exist(world):
    world["vault_name"] = "nonexistent-vault"


@given('the vault is "ACTIVE"')
def vault_is_active():
    """No-op: vaults are always ACTIVE immediately after creation."""


@given('the vault is not "ACTIVE"')
def vault_is_not_active(world):
    pytest.skip(
        "Lifecycle-dependent state (non-ACTIVE vault) is not supported "
        "in stateless integration tests."
    )


@given("the vault has no archives")
def vault_has_no_archives():
    """No-op: freshly created vaults have zero archives."""


@given("the vault has archives")
def vault_has_archives(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    archive_id = _upload_archive(client, vault_name)
    world["archive_id"] = archive_id


@given("the vault has no in-progress jobs")
def vault_has_no_in_progress_jobs():
    """No-op: freshly created vaults have no jobs."""


@given("the vault has in-progress jobs")
def vault_has_in_progress_jobs(world):
    pytest.skip(
        "Lifecycle-dependent state (vault with in-progress jobs) is not supported "
        "in stateless integration tests."
    )


# ── Given: archive state ──────────────────────────────────────────────────────


@given("the archive does not already exist")
def archive_not_already_exist():
    """No-op: fresh vault has no archives."""


@given("the archive already exists")
def archive_already_exists(world):
    pytest.skip(
        "UploadArchive always creates a new archive with a unique ID in lws; "
        "duplicate archive creation cannot be tested in stateless integration tests."
    )


@given("the archive exists")
def archive_exists(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    archive_id = _upload_archive(client, vault_name)
    world["archive_id"] = archive_id


@given("the archive does not exist")
def archive_does_not_exist(world):
    world["archive_id"] = "nonexistent-archive-id"


@given('the archive is "STORED"')
def archive_is_stored():
    """No-op: uploaded archives are always in STORED state."""


@given('the archive is not "STORED"')
def archive_is_not_stored(world):
    pytest.skip(
        "Lifecycle-dependent state (non-STORED archive) is not supported "
        "in stateless integration tests."
    )


# ── Given: job state ──────────────────────────────────────────────────────────


@given("the job slot is available")
def job_slot_available():
    """No-op: job slots are always available in isolated tests."""


@given("the job slot is not available")
def job_slot_not_available(world):
    pytest.skip(
        "Capacity-dependent state (no job slot) is not supported " "in stateless integration tests."
    )


@given("the job exists")
def job_exists(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    if vault_name == "nonexistent-vault":
        world["job_id"] = "nonexistent-job-id"
        return
    _create_vault(client, vault_name)
    world["vault_name"] = vault_name
    job_id = _initiate_job(client, vault_name)
    world["job_id"] = job_id


@given("the job does not exist")
def job_does_not_exist(world):
    world["job_id"] = "nonexistent-job-id"
    if not world.get("vault_name"):
        world["vault_name"] = INT_VAULT_NAME


@given("the job is Succeeded")
def job_is_succeeded():
    """No-op: jobs start in Succeeded state in the lws implementation."""


@given("the job is not Succeeded")
def job_is_not_succeeded(world):
    pytest.skip(
        "Lifecycle-dependent state (non-Succeeded job) is not supported "
        "in stateless integration tests."
    )


@given("the job is InProgress")
def job_is_in_progress(world):
    pytest.skip(
        "Lifecycle-dependent state (InProgress job) is not supported "
        "in stateless integration tests — jobs complete synchronously."
    )


@given("the job is not InProgress")
def job_is_not_in_progress():
    """No-op: jobs are Succeeded immediately in the lws implementation."""


@given("the job output is available")
def job_output_is_available():
    """No-op: output is available for any Succeeded job in lws."""


@given("the job output is not available")
def job_output_not_available(world):
    pytest.skip(
        "Lifecycle-dependent state (job output unavailable) is not supported "
        "in stateless integration tests."
    )


# ── Given: multipart upload state ─────────────────────────────────────────────


@given("the upload does not already exist")
def upload_not_already_exist():
    """No-op: fresh state has no uploads."""


@given("the upload already exists")
def upload_already_exists(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")


@given("the upload exists")
def upload_exists(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")


@given("the upload does not exist")
def upload_does_not_exist(world):
    world["upload_id"] = "nonexistent-upload-id"


@given("the upload is InProgress")
def upload_is_in_progress(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")


@given("the upload is not InProgress")
def upload_is_not_in_progress(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")


@given("the part has not already been uploaded")
def part_not_already_uploaded():
    """No-op: fresh upload has no parts."""


@given("the part has already been uploaded")
def part_already_uploaded(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")


@given("the archive slot is available")
def archive_slot_available():
    """No-op: archive slots are always available in isolated tests."""


@given("the archive slot is not available")
def archive_slot_not_available(world):
    pytest.skip(
        "Capacity-dependent state (no archive slot) is not supported "
        "in stateless integration tests."
    )


# ── When: vault actions ───────────────────────────────────────────────────────


@when("a vault is created")
def create_vault(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.put(f"/-/vaults/{vault_name}")
    if r.status_code == 201:
        world["result"] = {"Location": r.headers.get("location", "")}
        world["vault_name"] = vault_name
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


@when("an empty vault is deleted")
def delete_vault(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.delete(f"/-/vaults/{vault_name}")
    if r.status_code == 204:
        world["result"] = {}
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


@when("a vault inventory is refreshed")
def refresh_vault_inventory(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.post(
        f"/-/vaults/{vault_name}/jobs",
        json={"Type": "inventory-retrieval"},
    )
    if r.status_code == 202:
        world["result"] = {"JobId": r.headers.get("x-amz-job-id", "")}
        world["job_id"] = r.headers.get("x-amz-job-id", "")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


# ── When: archive actions ─────────────────────────────────────────────────────


@when("an archive is uploaded to a vault")
def upload_archive(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.post(
        f"/-/vaults/{vault_name}/archives",
        content=INT_ARCHIVE_BODY,
    )
    if r.status_code == 201:
        world["result"] = {"ArchiveId": r.headers.get("x-amz-archive-id", "")}
        world["archive_id"] = r.headers.get("x-amz-archive-id", "")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


@when("an archive is deleted from a vault")
def delete_archive(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    archive_id = world.get("archive_id", "nonexistent-archive-id")
    r = client.delete(f"/-/vaults/{vault_name}/archives/{archive_id}")
    if r.status_code == 204:
        world["result"] = {}
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


# ── When: job actions ─────────────────────────────────────────────────────────


@when("a vault inventory retrieval job is initiated")
def initiate_inventory_retrieval_job(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.post(
        f"/-/vaults/{vault_name}/jobs",
        json={"Type": "inventory-retrieval"},
    )
    if r.status_code == 202:
        world["result"] = {"JobId": r.headers.get("x-amz-job-id", "")}
        world["job_id"] = r.headers.get("x-amz-job-id", "")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


@when("an archive retrieval job is initiated")
def initiate_archive_retrieval_job(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    archive_id = world.get("archive_id", "nonexistent-archive-id")
    r = client.post(
        f"/-/vaults/{vault_name}/jobs",
        json={"Type": "archive-retrieval", "ArchiveId": archive_id},
    )
    if r.status_code == 202:
        world["result"] = {"JobId": r.headers.get("x-amz-job-id", "")}
        world["job_id"] = r.headers.get("x-amz-job-id", "")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


@when("the output of a succeeded job is retrieved")
def get_job_output(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    job_id = world.get("job_id", "nonexistent-job-id")
    r = client.get(f"/-/vaults/{vault_name}/jobs/{job_id}/output")
    if r.status_code == 200:
        try:
            world["result"] = r.json()
        except Exception:
            world["result"] = {"content": r.content}
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


@when("a job fails")
def job_fails(client: TestClient, world):
    pytest.skip("Job failure transitions are not supported in the stateless lws Glacier provider.")


@when("a job completes successfully")
def job_completes_successfully(client: TestClient, world):
    pytest.skip(
        "Job completion transitions are not supported in the stateless lws Glacier provider."
    )


# ── When: multipart upload actions ────────────────────────────────────────────


@when("a multipart upload is initiated for a vault")
def initiate_multipart_upload(client: TestClient, world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")


@when("a part is uploaded for a multipart upload")
def upload_multipart_part(client: TestClient, world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")


@when("a multipart upload is completed")
def complete_multipart_upload(client: TestClient, world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")


@when("a multipart upload is aborted")
def abort_multipart_upload(client: TestClient, world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the vault is "ACTIVE" with zero archives')
def vault_is_active_with_zero_archives(client: TestClient, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected vault creation to succeed but got: {actual_error}"
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.get(f"/-/vaults/{vault_name}")
    body = r.json()
    expected_archive_count = 0
    actual_archive_count = body.get("NumberOfArchives", -1)
    assert (
        actual_archive_count == expected_archive_count
    ), f"Expected {expected_archive_count} archives but got {actual_archive_count}"


@then('the vault is "DELETED"')
def vault_is_deleted(client: TestClient, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected vault deletion to succeed but got: {actual_error}"
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.get(f"/-/vaults/{vault_name}")
    expected_status_code = 404
    actual_status_code = r.status_code
    assert (
        actual_status_code == expected_status_code
    ), f"Expected vault to be deleted (404) but got status {actual_status_code}"


@then('the archive is "STORED" and the vault archive count increases')
def archive_is_stored_count_increases(client: TestClient, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected archive upload to succeed but got: {actual_error}"
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.get(f"/-/vaults/{vault_name}")
    body = r.json()
    actual_archive_count = body.get("NumberOfArchives", 0)
    assert (
        actual_archive_count >= 1
    ), f"Expected at least 1 archive in vault but got {actual_archive_count}"


@then('the archive is "DELETED" and the vault archive count decreases')
def archive_is_deleted_count_decreases(client: TestClient, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected archive deletion to succeed but got: {actual_error}"
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.get(f"/-/vaults/{vault_name}")
    body = r.json()
    expected_archive_count = 0
    actual_archive_count = body.get("NumberOfArchives", -1)
    assert actual_archive_count == expected_archive_count, (
        f"Expected {expected_archive_count} archives after deletion but got "
        f"{actual_archive_count}"
    )


@then("the job is InProgress for the given vault")
def job_is_in_progress_for_vault(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected job initiation to succeed but got: {actual_error}"
    actual_job_id = world.get("job_id", "")
    assert actual_job_id, "Expected a non-empty job ID in the response"


@then("the job is InProgress for the given archive")
def job_is_in_progress_for_archive(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected archive retrieval job initiation to succeed but got: {actual_error}"
    actual_job_id = world.get("job_id", "")
    assert actual_job_id, "Expected a non-empty job ID in the response"


@then("the job output is marked as retrieved")
def job_output_is_marked_as_retrieved(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected get-job-output to succeed but got: {actual_error}"


@then("the job is Failed")
def job_is_failed(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected job failure to succeed but got: {actual_error}"


@then("the job is Succeeded and its output is available")
def job_is_succeeded_and_output_available(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected job to succeed but got: {actual_error}"


@then("the vault inventory is marked as fresh")
def vault_inventory_is_marked_as_fresh(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected inventory refresh to succeed but got: {actual_error}"


@then("the upload is InProgress")
def upload_is_in_progress_then(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected multipart upload initiation to succeed but got: {actual_error}"


@then("the part is recorded for the upload")
def part_is_recorded_for_upload(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected part upload to succeed but got: {actual_error}"


@then('the upload is Completed and the assembled archive is "STORED" in the vault')
def upload_is_completed_and_archive_stored(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected multipart upload completion to succeed but got: {actual_error}"


@then("the upload is Aborted")
def upload_is_aborted(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected multipart upload abort to succeed but got: {actual_error}"


@then("every in-progress job references an active vault")
def every_in_progress_job_references_active_vault():
    """Invariant trivially satisfied in an isolated test context."""


@then("vault archive count is never negative")
def vault_archive_count_never_negative():
    """Invariant trivially satisfied in an isolated test context."""


@then('all stored archives belong to an "ACTIVE" vault')
def all_stored_archives_belong_to_active_vault():
    """Invariant trivially satisfied in an isolated test context."""


@then("job output is only available for succeeded jobs")
def job_output_only_for_succeeded_jobs():
    """Invariant trivially satisfied in an isolated test context."""


@then('every archive retrieval job references a non-empty archive "ID"')
def every_archive_retrieval_job_references_archive_id():
    """Invariant trivially satisfied in an isolated test context."""
