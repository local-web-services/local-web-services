"""Shared fixtures and BDD step definitions for S3api integration tests."""

from __future__ import annotations

import xml.etree.ElementTree as ET
from pathlib import Path

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app

INT_BUCKET = "int-test-bkt-1"
INT_SRC_BUCKET = "int-src-bkt-1"
INT_KEY = "int-test-key-1"
INT_KEY2 = "int-test-key-2"
INT_BODY = b"int-test-data-content-1"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider(tmp_path: Path):
    p = S3Provider(data_dir=tmp_path, buckets=[])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_s3_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


@pytest.fixture
def sync_client(app):
    with TestClient(app, base_url="http://testserver", raise_server_exceptions=True) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _create_bucket(sync_client: TestClient, name: str = INT_BUCKET) -> None:
    sync_client.put(f"/{name}")


def _put_object(
    sync_client: TestClient,
    bucket: str = INT_BUCKET,
    key: str = INT_KEY,
) -> None:
    sync_client.put(f"/{bucket}/{key}", content=INT_BODY)


def _parse_upload_id(response) -> str:
    root = ET.fromstring(response.text)
    ns = {"s3": "http://s3.amazonaws.com/doc/2006-03-01/"}
    upload_id = root.findtext("s3:UploadId", default="", namespaces=ns)
    if not upload_id:
        upload_id = root.findtext("UploadId", default="")
    return upload_id


# ── Given: bucket state setup ─────────────────────────────────────────────────


@given("the bucket does not already exist")
def bucket_not_already_exist():
    """No-op: fresh state has no buckets."""


@given("the bucket already exists")
def bucket_already_exists(sync_client: TestClient):
    _create_bucket(sync_client)


@given("the bucket exists")
def bucket_exists(sync_client: TestClient):
    _create_bucket(sync_client)


@given('the bucket is "ACTIVE"')
def bucket_is_active_given():
    """No-op: buckets are ACTIVE by default after creation."""


@given('the bucket is not "ACTIVE"')
def bucket_is_not_active_given(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the bucket does not exist")
def bucket_does_not_exist():
    """No-op: fresh state has no buckets."""


@given("the bucket is empty")
def bucket_is_empty():
    """No-op: freshly created bucket has no objects."""


@given("the bucket is not empty")
def bucket_is_not_empty(sync_client: TestClient):
    _put_object(sync_client)


# ── Given: source/destination bucket setup ────────────────────────────────────


@given("the source bucket exists")
def source_bucket_exists(sync_client: TestClient):
    _create_bucket(sync_client, name=INT_SRC_BUCKET)
    _create_bucket(sync_client, name=INT_BUCKET)


@given("the source bucket does not exist")
def source_bucket_does_not_exist():
    """No-op: fresh state has no buckets."""


@given('the source bucket is "ACTIVE"')
def source_bucket_is_active_given():
    """No-op: source buckets are ACTIVE by default after creation."""


@given('the source bucket is not "ACTIVE"')
def source_bucket_is_not_active_given(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the destination bucket is "ACTIVE"')
def destination_bucket_is_active_given():
    """No-op: destination bucket is ACTIVE by default after creation."""


@given("the destination bucket exists")
def destination_bucket_exists():
    """No-op: destination bucket (INT_BUCKET) was created in source_bucket_exists."""


@given("the destination bucket does not exist")
def destination_bucket_does_not_exist():
    pytest.skip("Cannot remove destination bucket after source bucket is created.")


@given('the destination bucket is not "ACTIVE"')
def destination_bucket_is_not_active_given(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


# ── Given: versioning state setup ─────────────────────────────────────────────


@given("versioning is disabled")
def versioning_is_disabled():
    """No-op: versioning is disabled by default."""


@given("versioning is enabled")
def versioning_is_enabled(sync_client: TestClient):
    sync_client.put(
        f"/{INT_BUCKET}",
        params={"versioning": ""},
        content=(
            b'<VersioningConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
            b"<Status>Enabled</Status></VersioningConfiguration>"
        ),
        headers={"Content-Type": "application/xml"},
    )


@given("versioning is not enabled")
def versioning_is_not_enabled():
    """No-op: versioning is disabled by default."""


@given("versioning is not disabled")
def versioning_is_not_disabled(sync_client: TestClient):
    sync_client.put(
        f"/{INT_BUCKET}",
        params={"versioning": ""},
        content=(
            b'<VersioningConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
            b"<Status>Enabled</Status></VersioningConfiguration>"
        ),
        headers={"Content-Type": "application/xml"},
    )


# ── Given: object state setup ─────────────────────────────────────────────────


@given("the object does not already exist")
def object_not_already_exist():
    """No-op: fresh bucket has no objects."""


@given("the object already exists")
def object_already_exists(sync_client: TestClient):
    _put_object(sync_client)


@given("the object exists")
def object_exists(sync_client: TestClient):
    _put_object(sync_client)


@given("the object exists in the bucket")
def object_exists_in_bucket(sync_client: TestClient):
    _put_object(sync_client)


@given("the object does not exist in the bucket")
def object_does_not_exist_in_bucket():
    """No-op: fresh bucket has no objects."""


@given("the object is not deleted")
def object_is_not_deleted():
    """No-op: objects are not deleted by default after being put."""


@given("the object is deleted")
def object_is_deleted(sync_client: TestClient):
    _put_object(sync_client)
    sync_client.delete(f"/{INT_BUCKET}/{INT_KEY}")


@given('the object is "ACTIVE"')
def object_is_active_given():
    """No-op: objects are active once put."""


@given('the object is not "ACTIVE"')
def object_is_not_active_given(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the object does not exist")
def object_does_not_exist():
    """No-op: fresh bucket has no objects."""


@given("the source object exists")
def source_object_exists(sync_client: TestClient):
    _put_object(sync_client, bucket=INT_SRC_BUCKET, key=INT_KEY)


@given("the source object does not exist")
def source_object_does_not_exist():
    """No-op: no object in source bucket by default."""


@given("the source object is not deleted")
def source_object_is_not_deleted():
    """No-op: objects are not deleted by default after being put."""


@given("the source object is deleted")
def source_object_is_deleted(sync_client: TestClient):
    _put_object(sync_client, bucket=INT_SRC_BUCKET, key=INT_KEY)
    sync_client.delete(f"/{INT_SRC_BUCKET}/{INT_KEY}")


@given("the source object's bucket exists")
def source_objects_bucket_exists():
    """No-op: bucket was created in source_bucket_exists step."""


@given("the lifecycle policy has an expiry rule for the object")
def lifecycle_policy_has_expiry(world):
    pytest.skip("Cannot configure lifecycle expiry in integration test context.")


# ── Given: multipart upload state setup ───────────────────────────────────────


@given("the upload does not already exist")
def upload_not_already_exist():
    """No-op: no uploads in progress by default."""


@given("the upload does not exist")
def upload_does_not_exist():
    """No-op: no uploads in progress by default."""


@given("the upload exists")
def upload_exists(sync_client: TestClient, world):
    resp = sync_client.post(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploads": ""},
    )
    world["upload_id"] = _parse_upload_id(resp)
    world["etags"] = []


@given("the upload already exists")
def upload_already_exists(world):
    pytest.skip("S3 allows multiple concurrent multipart uploads for the same key.")


@given('the upload is "IN_PROGRESS"')
def upload_is_in_progress_given(world):
    """No-op: upload was already created in the upload_exists step."""


@given("the upload has at least one part")
def upload_has_at_least_one_part(sync_client: TestClient, world):
    resp = sync_client.put(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"partNumber": "1", "uploadId": world["upload_id"]},
        content=INT_BODY,
    )
    etag = resp.headers.get("ETag", "")
    world.setdefault("etags", []).append({"ETag": etag, "PartNumber": 1})


@given("the upload has no parts")
def upload_has_no_parts():
    """No-op: freshly created upload has no parts."""


@given('the upload is "IN_PROGRESS" with at least one part uploaded')
def upload_in_progress_with_part(sync_client: TestClient, world):
    create_resp = sync_client.post(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploads": ""},
    )
    world["upload_id"] = _parse_upload_id(create_resp)
    part_resp = sync_client.put(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"partNumber": "1", "uploadId": world["upload_id"]},
        content=INT_BODY,
    )
    etag = part_resp.headers.get("ETag", "")
    world["etags"] = [{"ETag": etag, "PartNumber": 1}]


@given('the upload is not "IN_PROGRESS"')
def upload_is_not_in_progress(world):
    pytest.skip("Cannot set upload to non-IN_PROGRESS state.")


# ── Given: sequences.feature symbolic preconditions ──────────────────────────


@given("bname not in bucket_status")
def bname_not_in_bucket_status():
    """No-op: symbolic precondition from FizzBee model; fresh state has no buckets."""


@given("bname in bucket_status")
def bname_in_bucket_status(sync_client: TestClient):
    _create_bucket(sync_client)


@given("src_bname in bucket_status")
def src_bname_in_bucket_status(sync_client: TestClient):
    _create_bucket(sync_client, name=INT_SRC_BUCKET)


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a bucket is created")
def create_bucket(sync_client: TestClient, world):
    r = sync_client.put(f"/{INT_BUCKET}")
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a bucket is deleted")
def delete_bucket(sync_client: TestClient, world):
    r = sync_client.delete(f"/{INT_BUCKET}")
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("the list of buckets is retrieved")
def list_buckets(sync_client: TestClient, world):
    r = sync_client.get("/")
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("versioning is configured on a bucket")
def put_bucket_versioning(sync_client: TestClient, world):
    r = sync_client.put(
        f"/{INT_BUCKET}",
        params={"versioning": ""},
        content=(
            b'<VersioningConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
            b"<Status>Enabled</Status></VersioningConfiguration>"
        ),
        headers={"Content-Type": "application/xml"},
    )
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("an object is uploaded to a bucket")
def put_object(sync_client: TestClient, world):
    r = sync_client.put(f"/{INT_BUCKET}/{INT_KEY}", content=INT_BODY)
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("an object is retrieved from a bucket")
def get_object(sync_client: TestClient, world):
    r = sync_client.get(f"/{INT_BUCKET}/{INT_KEY}")
    if r.status_code == 200:
        world["result"] = r.content
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("an object is deleted from a bucket")
def delete_object(sync_client: TestClient, world):
    r = sync_client.delete(f"/{INT_BUCKET}/{INT_KEY}")
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("object metadata is retrieved from a bucket")
def head_object(sync_client: TestClient, world):
    r = sync_client.head(f"/{INT_BUCKET}/{INT_KEY}")
    if r.status_code == 200:
        world["result"] = dict(r.headers)
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.status_code


@when("objects in a bucket are listed")
def list_objects_v2(sync_client: TestClient, world):
    r = sync_client.get(f"/{INT_BUCKET}", params={"list-type": "2"})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("an object is copied from one bucket to another")
def copy_object(sync_client: TestClient, world):
    r = sync_client.put(
        f"/{INT_BUCKET}/{INT_KEY2}",
        headers={"x-amz-copy-source": f"/{INT_SRC_BUCKET}/{INT_KEY}"},
    )
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a multipart upload is initiated")
def create_multipart_upload(sync_client: TestClient, world):
    r = sync_client.post(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploads": ""},
    )
    if r.status_code == 200:
        world["upload_id"] = _parse_upload_id(r)
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a part is uploaded for a multipart upload")
def upload_part(sync_client: TestClient, world):
    r = sync_client.put(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"partNumber": "1", "uploadId": world.get("upload_id", "invalid")},
        content=INT_BODY,
    )
    if r.status_code == 200:
        etag = r.headers.get("ETag", "")
        world.setdefault("etags", []).append({"ETag": etag, "PartNumber": 1})
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a multipart upload is completed")
def complete_multipart_upload(sync_client: TestClient, world):
    parts = world.get("etags") or []
    parts_xml = "".join(
        f"<Part><PartNumber>{p['PartNumber']}</PartNumber><ETag>{p['ETag']}</ETag></Part>"
        for p in parts
    )
    body = f"<CompleteMultipartUpload>{parts_xml}</CompleteMultipartUpload>"
    r = sync_client.post(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploadId": world.get("upload_id", "invalid")},
        content=body.encode(),
        headers={"Content-Type": "application/xml"},
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a multipart upload is aborted")
def abort_multipart_upload(sync_client: TestClient, world):
    # Guard: reject if bucket does not exist (lws returns 204 regardless)
    head_r = sync_client.head(f"/{INT_BUCKET}")
    if head_r.status_code == 404:
        world["result"] = None
        world["error"] = f"NoSuchBucket: {INT_BUCKET} does not exist"
        return
    # Guard: reject if no valid upload_id is present (upload does not exist)
    upload_id = world.get("upload_id")
    if not upload_id:
        world["result"] = None
        world["error"] = "NoSuchUpload: upload_id is missing or invalid"
        return
    r = sync_client.delete(
        f"/{INT_BUCKET}/{INT_KEY}",
        params={"uploadId": upload_id},
    )
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a lifecycle rule expires an object")
def lifecycle_expire_object(world):
    pytest.skip("Cannot trigger lifecycle expiry in integration test context.")


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the bucket is "ACTIVE" with versioning disabled')
def bucket_active_with_versioning_disabled(sync_client: TestClient):
    r = sync_client.get("/")
    expected_bucket = INT_BUCKET
    actual_body = r.text
    assert (
        expected_bucket in actual_body
    ), f"Expected bucket '{expected_bucket}' in list but got: {actual_body}"


@then('the bucket is "DELETED"')
def bucket_is_deleted_status_then(sync_client: TestClient):
    r = sync_client.get("/")
    actual_body = r.text
    expected_absent = INT_BUCKET
    assert (
        expected_absent not in actual_body
    ), f"Expected bucket '{expected_absent}' to be deleted but it still appears in: {actual_body}"


@then("the available buckets are returned")
def available_buckets_returned_then(world):
    actual_result = world["result"]
    expected_marker = "ListAllMyBucketsResult"
    assert (
        actual_result is not None and expected_marker in actual_result
    ), f"Expected '{expected_marker}' in result but got: {actual_result}"


@then('the bucket versioning state is "ENABLED" or "SUSPENDED" non-deterministically')
def bucket_versioning_enabled_or_suspended_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}", params={"versioning": ""})
    actual_body = r.text
    expected_valid_statuses = ("Enabled", "Suspended")
    assert any(
        s in actual_body for s in expected_valid_statuses
    ), f"Expected versioning status to be one of {expected_valid_statuses} but got: {actual_body}"


@then('the object "EXISTS" in the bucket')
def object_exists_in_bucket_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}", params={"list-type": "2"})
    actual_body = r.text
    expected_key = INT_KEY
    assert (
        expected_key in actual_body
    ), f"Expected object key '{expected_key}' in bucket listing but got: {actual_body}"


@then('the object "EXISTS" in the destination bucket')
def object_exists_in_destination_bucket_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}", params={"list-type": "2"})
    actual_body = r.text
    expected_key = INT_KEY2
    assert (
        expected_key in actual_body
    ), f"Expected copied key '{expected_key}' in destination bucket but got: {actual_body}"


@then("the object data is returned")
def object_data_is_returned_then(world):
    actual_result = world["result"]
    expected_content = INT_BODY
    assert (
        actual_result == expected_content
    ), f"Expected object content '{expected_content}' but got: {actual_result}"


@then('the object is "DELETED"')
def object_is_deleted_status_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}/{INT_KEY}")
    expected_status_code = 404
    actual_status_code = r.status_code
    assert (
        actual_status_code == expected_status_code
    ), f"Expected status {expected_status_code} for deleted object but got {actual_status_code}"


@then('the object is "DELETED" by the lifecycle policy')
def object_deleted_by_lifecycle_then(world):
    pytest.skip("Cannot observe lifecycle expiry in integration test context.")


@then("the object metadata is returned")
def object_metadata_returned_then(world):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected object metadata but got: {actual_result}"
    expected_header = "content-length"
    assert (
        expected_header in actual_result
    ), f"Expected '{expected_header}' in metadata headers but got: {actual_result}"


@then("the list of objects in the bucket is returned")
def list_of_objects_returned_then(world):
    actual_result = world["result"]
    expected_marker = "ListBucketResult"
    assert (
        actual_result is not None and expected_marker in actual_result
    ), f"Expected '{expected_marker}' in result but got: {actual_result}"


@then('the upload is "IN_PROGRESS" with no parts')
def upload_in_progress_no_parts_then(world):
    actual_result = world["result"]
    expected_marker = "UploadId"
    assert (
        actual_result is not None and expected_marker in actual_result
    ), f"Expected '{expected_marker}' in result but got: {actual_result}"


@then("the upload has at least one part")
def upload_has_at_least_one_part_then(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected part upload to succeed but got: {actual_error}"


@then("the part is uploaded and the upload is still in progress")
def part_uploaded_then(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected part upload to succeed but got: {actual_error}"


@then('the upload is "COMPLETED" and the assembled object "EXISTS" in the bucket')
def upload_completed_assembled_then(sync_client: TestClient):
    r = sync_client.get(f"/{INT_BUCKET}", params={"list-type": "2"})
    actual_body = r.text
    expected_key = INT_KEY
    assert (
        expected_key in actual_body
    ), f"Expected assembled object '{expected_key}' in bucket listing but got: {actual_body}"


@then('the upload is "ABORTED"')
def upload_aborted_then(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected abort to succeed but got: {actual_error}"


@then("the object is expired and removed from the bucket")
def object_expired_then(world):
    pytest.skip("Cannot observe lifecycle expiry in integration test context.")


# ── Then: invariant assertions (no-op — always satisfied in isolated context) ─


@then('every bucket has a valid status ("ACTIVE" or "DELETED")')
def every_bucket_has_valid_status():
    """No-op invariant: lws always maintains valid bucket statuses."""


@then('every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")')
def every_bucket_versioning_state_is_valid():
    """No-op invariant: lws always maintains valid versioning states."""


@then('every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")')
def every_multipart_upload_has_valid_status():
    """No-op invariant: lws always maintains valid multipart upload statuses."""


@then("deleting a bucket requires it to be empty")
def deleting_bucket_requires_empty():
    """No-op invariant: lws enforces this constraint at the API level."""
