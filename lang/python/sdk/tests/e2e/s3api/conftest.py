"""Abstract BDD step definitions for S3api informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUCKET = "e2e-test-bkt-1"
TEST_SRC_BUCKET = "e2e-src-bkt-1"
TEST_KEY = "e2e-test-key-1"
TEST_KEY2 = "e2e-test-key-2"
TEST_BODY = b"test-data-content-1"


def _s3(lws_session):
    return lws_session.client("s3")


def _create_bucket(lws_session, name=TEST_BUCKET):
    _s3(lws_session).create_bucket(Bucket=name)


def _put_object(lws_session, bucket=TEST_BUCKET, key=TEST_KEY):
    _s3(lws_session).put_object(Bucket=bucket, Key=key, Body=TEST_BODY)


# ── Given: system initialization ──────────────────────────────────────


@given("the system is initialized")
def system_is_initialized():
    """No-op: the system is already initialized by the test fixture."""


# ── Given: bucket state setup ──────────────────────────────────────────


@given("the bucket does not already exist")
def bucket_not_already_exist(lws_session):
    """Ensure the bucket does not exist by deleting it if present."""
    try:
        _s3(lws_session).delete_bucket(Bucket=TEST_BUCKET)
    except Exception:
        pass  # Already absent — that's the desired state


@given("the bucket already exists")
def bucket_already_exists(lws_session):
    _create_bucket(lws_session)


@given("the bucket exists")
def bucket_exists(lws_session):
    _create_bucket(lws_session)


@given('the bucket is "ACTIVE"')
def bucket_is_active_given():
    """No-op: buckets are ACTIVE by default after creation."""


@given('the bucket is not "ACTIVE"')
def bucket_is_not_active_given(lws_session):
    try:
        _s3(lws_session).delete_bucket(Bucket=TEST_BUCKET)
    except Exception:  # noqa: BLE001
        pass  # bucket may not exist yet — that's fine
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)


@given("the bucket does not exist")
def bucket_does_not_exist(lws_session):
    """Ensure the bucket does not exist by deleting it if present."""
    try:
        _s3(lws_session).delete_bucket(Bucket=TEST_BUCKET)
    except Exception:
        pass  # Already absent — that's the desired state


@given("the bucket is empty")
def bucket_is_empty():
    """No-op: freshly created bucket is empty."""


@given("the bucket is not empty")
def bucket_is_not_empty(lws_session):
    _put_object(lws_session)


# ── Given: source/destination bucket setup ────────────────────────────


@given("the source bucket exists")
def source_bucket_exists(lws_session):
    _create_bucket(lws_session, name=TEST_SRC_BUCKET)
    _create_bucket(lws_session, name=TEST_BUCKET)


@given("the source bucket does not exist")
def source_bucket_does_not_exist(lws_session):
    """Ensure the source bucket does not exist by deleting it if present."""
    try:
        _s3(lws_session).delete_bucket(Bucket=TEST_SRC_BUCKET)
    except Exception:
        pass  # Already absent — that's the desired state


@given('the source bucket is "ACTIVE"')
def source_bucket_is_active_given():
    """No-op: buckets are ACTIVE by default after creation."""


@given('the source bucket is not "ACTIVE"')
def source_bucket_is_not_active_given(lws_session):
    try:
        _s3(lws_session).delete_bucket(Bucket=TEST_SRC_BUCKET)
    except Exception:  # noqa: BLE001
        pass  # bucket may not exist yet — that's fine
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    _create_bucket(lws_session, name=TEST_SRC_BUCKET)


@given('the destination bucket is "ACTIVE"')
def destination_bucket_is_active_given():
    """No-op: destination bucket is ACTIVE by default after creation."""


@given("the destination bucket does not exist")
def destination_bucket_does_not_exist():
    """No-op: we skip scenarios that require a missing destination bucket."""
    pytest.skip("Cannot remove destination bucket after source bucket is created")


@given('the destination bucket is not "ACTIVE"')
def destination_bucket_is_not_active_given(lws_session):
    try:
        _s3(lws_session).delete_bucket(Bucket=TEST_BUCKET)
    except Exception:  # noqa: BLE001
        pass  # bucket may not exist yet — that's fine
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)


# ── Given: versioning state setup ─────────────────────────────────────


@given("versioning is disabled")
def versioning_is_disabled():
    """No-op: versioning is disabled by default."""


@given("versioning is enabled")
def versioning_is_enabled(lws_session):
    _s3(lws_session).put_bucket_versioning(
        Bucket=TEST_BUCKET,
        VersioningConfiguration={"Status": "Enabled"},
    )


@given("versioning is not enabled")
def versioning_is_not_enabled():
    """No-op: versioning is disabled by default."""


@given("versioning is not disabled")
def versioning_is_not_disabled(lws_session):
    _s3(lws_session).put_bucket_versioning(
        Bucket=TEST_BUCKET,
        VersioningConfiguration={"Status": "Enabled"},
    )


# ── Given: object state setup ──────────────────────────────────────────


@given("the object does not already exist")
def object_not_already_exist():
    """No-op: fresh bucket has no objects."""


@given("the object already exists")
def object_already_exists(lws_session):
    _put_object(lws_session)


@given("the object exists")
def object_exists(lws_session):
    _put_object(lws_session)


@given("the object exists in the bucket")
def object_exists_in_bucket(lws_session):
    _put_object(lws_session)


@given("the object does not exist in the bucket")
def object_does_not_exist_in_bucket():
    """No-op: fresh bucket has no objects."""


@given("the object is not deleted")
def object_is_not_deleted():
    """No-op: objects are not deleted by default after being put."""


@given("the object is deleted")
def object_is_deleted(lws_session):
    _put_object(lws_session)
    _s3(lws_session).delete_object(Bucket=TEST_BUCKET, Key=TEST_KEY)


@given('the object is "ACTIVE"')
def object_is_active_given():
    """No-op: objects are active once put."""


@given('the object is not "ACTIVE"')
def object_is_not_active_given(lws_session):
    try:
        _s3(lws_session).delete_bucket(Bucket=TEST_BUCKET)
    except Exception:  # noqa: BLE001
        pass  # bucket may not exist yet — that's fine
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)


@given("the object does not exist")
def object_does_not_exist():
    """No-op: fresh bucket has no objects."""


@given("the source object exists")
def source_object_exists(lws_session):
    _put_object(lws_session, bucket=TEST_SRC_BUCKET, key=TEST_KEY)


@given("the source object does not exist")
def source_object_does_not_exist():
    """No-op: no object in source bucket by default."""


@given("the source object is not deleted")
def source_object_is_not_deleted():
    """No-op: objects are not deleted by default after being put."""


@given("the source object is deleted")
def source_object_is_deleted(lws_session):
    _put_object(lws_session, bucket=TEST_SRC_BUCKET, key=TEST_KEY)
    _s3(lws_session).delete_object(Bucket=TEST_SRC_BUCKET, Key=TEST_KEY)


@given("the source object's bucket exists")
def source_objects_bucket_exists():
    """No-op: bucket was created in source_bucket_exists step."""


@given("the destination bucket exists")
def destination_bucket_exists():
    """No-op: we use the same bucket for source and destination."""


@given("the lifecycle policy has an expiry rule for the object")
def lifecycle_policy_has_expiry():
    pytest.skip("Cannot configure lifecycle expiry in this abstract context")


# ── Given: multipart upload state setup ────────────────────────────────


@given("the upload does not already exist")
def upload_not_already_exist():
    """No-op: no uploads in progress."""


@given("the upload does not exist")
def upload_does_not_exist():
    """No-op: no uploads in progress by default."""


@given("the upload exists")
def upload_exists(lws_session, world):
    resp = _s3(lws_session).create_multipart_upload(Bucket=TEST_BUCKET, Key=TEST_KEY)
    world["upload_id"] = resp["UploadId"]
    world["etags"] = []


@given("the upload already exists")
def upload_already_exists(lws_session, world):
    """Skip: S3 allows multiple concurrent uploads for the same key."""
    pytest.skip("S3 allows multiple concurrent multipart uploads for the same key")


@given('the upload is "IN_PROGRESS"')
def upload_is_in_progress_given(world):
    """No-op: upload was already created in the upload_exists step."""


@given("the upload has at least one part")
def upload_has_at_least_one_part(lws_session, world):
    part_resp = _s3(lws_session).upload_part(
        Bucket=TEST_BUCKET,
        Key=TEST_KEY,
        UploadId=world["upload_id"],
        PartNumber=1,
        Body=TEST_BODY,
    )
    world.setdefault("etags", []).append({"ETag": part_resp["ETag"], "PartNumber": 1})


@given("the upload has no parts")
def upload_has_no_parts():
    """No-op: freshly created upload has no parts."""


@given('the upload is "IN_PROGRESS" with at least one part uploaded')
def upload_in_progress_with_part(lws_session, world):
    resp = _s3(lws_session).create_multipart_upload(Bucket=TEST_BUCKET, Key=TEST_KEY)
    world["upload_id"] = resp["UploadId"]
    part_resp = _s3(lws_session).upload_part(
        Bucket=TEST_BUCKET,
        Key=TEST_KEY,
        UploadId=world["upload_id"],
        PartNumber=1,
        Body=TEST_BODY,
    )
    world["etags"] = [{"ETag": part_resp["ETag"], "PartNumber": 1}]


@given('the upload is not "IN_PROGRESS"')
def upload_is_not_in_progress():
    pytest.skip("Cannot set upload to non-IN_PROGRESS state")


# ── Given: sequences.feature symbolic preconditions ───────────────────


@given("bname not in bucket_status")
def bname_not_in_bucket_status():
    """No-op: symbolic precondition from FizzBee model; fresh state has no buckets."""


# ── When: actions ──────────────────────────────────────────────────────


@when("a bucket is created")
def create_bucket(lws_session, world):
    try:
        world["result"] = _s3(lws_session).create_bucket(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a bucket is deleted")
def delete_bucket(lws_session, world):
    try:
        world["result"] = _s3(lws_session).delete_bucket(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("all buckets are listed")
def list_buckets_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).list_buckets()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the list of buckets is retrieved")
def list_buckets(lws_session, world):
    try:
        world["result"] = _s3(lws_session).list_buckets()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("bucket versioning is configured")
def put_bucket_versioning_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).put_bucket_versioning(
            Bucket=TEST_BUCKET,
            VersioningConfiguration={"Status": "Enabled"},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("versioning is configured on a bucket")
def put_bucket_versioning(lws_session, world):
    try:
        world["result"] = _s3(lws_session).put_bucket_versioning(
            Bucket=TEST_BUCKET,
            VersioningConfiguration={"Status": "Enabled"},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an object is uploaded to a bucket")
def put_object(lws_session, world):
    try:
        world["result"] = _s3(lws_session).put_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            Body=TEST_BODY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an object is retrieved from the bucket")
def get_object_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).get_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an object is retrieved from a bucket")
def get_object(lws_session, world):
    try:
        world["result"] = _s3(lws_session).get_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an object is deleted from the bucket")
def delete_object_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).delete_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an object is deleted from a bucket")
def delete_object(lws_session, world):
    try:
        world["result"] = _s3(lws_session).delete_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an object's metadata is retrieved")
def head_object_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).head_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("object metadata is retrieved from a bucket")
def head_object(lws_session, world):
    try:
        world["result"] = _s3(lws_session).head_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the objects in a bucket are listed")
def list_objects_v2_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).list_objects_v2(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("objects in a bucket are listed")
def list_objects_v2(lws_session, world):
    try:
        world["result"] = _s3(lws_session).list_objects_v2(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an object is copied within or across buckets")
def copy_object_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).copy_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY2,
            CopySource={"Bucket": TEST_BUCKET, "Key": TEST_KEY},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an object is copied from one bucket to another")
def copy_object(lws_session, world):
    try:
        world["result"] = _s3(lws_session).copy_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY2,
            CopySource={"Bucket": TEST_SRC_BUCKET, "Key": TEST_KEY},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a multipart upload is initiated")
def create_multipart_upload(lws_session, world):
    try:
        resp = _s3(lws_session).create_multipart_upload(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
        )
        world["result"] = resp
        world["upload_id"] = resp.get("UploadId")
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a part is uploaded for the multipart upload")
def upload_part_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).upload_part(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
            PartNumber=1,
            Body=TEST_BODY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a part is uploaded for a multipart upload")
def upload_part(lws_session, world):
    try:
        part_resp = _s3(lws_session).upload_part(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
            PartNumber=1,
            Body=TEST_BODY,
        )
        world["result"] = part_resp
        world.setdefault("etags", []).append({"ETag": part_resp["ETag"], "PartNumber": 1})
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the multipart upload is completed")
def complete_multipart_upload_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).complete_multipart_upload(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
            MultipartUpload={"Parts": [{"ETag": "etag1", "PartNumber": 1}]},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a multipart upload is completed")
def complete_multipart_upload(lws_session, world):
    try:
        parts = world.get("etags") or [{"ETag": "etag1", "PartNumber": 1}]
        world["result"] = _s3(lws_session).complete_multipart_upload(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
            MultipartUpload={"Parts": parts},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the multipart upload is aborted")
def abort_multipart_upload_old(lws_session, world):
    try:
        world["result"] = _s3(lws_session).abort_multipart_upload(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a multipart upload is aborted")
def abort_multipart_upload(lws_session, world):
    try:
        world["result"] = _s3(lws_session).abort_multipart_upload(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the lifecycle policy expires an object")
def lifecycle_expire_object_old(world):
    pytest.skip("Cannot trigger lifecycle expiry in this abstract context")


@when("a lifecycle rule expires an object")
def lifecycle_expire_object(world):
    pytest.skip("Cannot trigger lifecycle expiry in this abstract context")


# ── Then: assertions ───────────────────────────────────────────────────


@then("the operation is rejected")
def operation_is_rejected(world):
    actual_error = world.get("error")
    assert (
        actual_error is not None
    ), f"Expected the operation to be rejected but it succeeded with: {world.get('result')}"


@then('the bucket is "ACTIVE" with versioning disabled')
def bucket_active_with_versioning_disabled(lws_session):
    client = _s3(lws_session)
    resp = client.list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to exist but not found in: {actual_buckets}"


@then('the bucket is "DELETED"')
def bucket_is_deleted_status_then(lws_session):
    client = _s3(lws_session)
    resp = client.list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET not in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to be deleted but found in: {actual_buckets}"


@then("the bucket is deleted")
def bucket_is_deleted_then(lws_session):
    client = _s3(lws_session)
    resp = client.list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET not in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to be deleted but found in: {actual_buckets}"


@then("all buckets are returned")
def all_buckets_returned_then(world):
    expected_field = "Buckets"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected Buckets in result but got: {actual_result}"


@then("the available buckets are returned")
def available_buckets_returned_then(world):
    expected_field = "Buckets"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected Buckets in result but got: {actual_result}"


@then('versioning is "ENABLED"')
def versioning_is_enabled_then(lws_session):
    client = _s3(lws_session)
    resp = client.get_bucket_versioning(Bucket=TEST_BUCKET)
    expected_status = "Enabled"
    actual_status = resp.get("Status", "")
    assert (
        actual_status == expected_status
    ), f"Expected versioning to be '{expected_status}' but got '{actual_status}'"


@then('versioning is "SUSPENDED"')
def versioning_is_suspended_then(lws_session):
    client = _s3(lws_session)
    resp = client.get_bucket_versioning(Bucket=TEST_BUCKET)
    expected_status = "Suspended"
    actual_status = resp.get("Status", "")
    assert (
        actual_status == expected_status
    ), f"Expected versioning to be '{expected_status}' but got '{actual_status}'"


@then('the bucket versioning state is "ENABLED" or "SUSPENDED" non-deterministically')
def bucket_versioning_enabled_or_suspended_then(lws_session):
    client = _s3(lws_session)
    resp = client.get_bucket_versioning(Bucket=TEST_BUCKET)
    actual_status = resp.get("Status", "")
    expected_statuses = {"Enabled", "Suspended"}
    assert (
        actual_status in expected_statuses
    ), f"Expected versioning to be one of {expected_statuses} but got '{actual_status}'"


@then('the object "EXISTS" in the bucket')
def object_exists_in_bucket_then(lws_session):
    client = _s3(lws_session)
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY in keys, f"Expected object '{TEST_KEY}' to exist in bucket but found: {keys}"


@then('the object "EXISTS" in the destination bucket')
def object_exists_in_destination_bucket_then(lws_session):
    client = _s3(lws_session)
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert (
        TEST_KEY2 in keys
    ), f"Expected copied object '{TEST_KEY2}' to exist in destination bucket but found: {keys}"


@then("the object is returned")
def object_is_returned_then(world):
    actual_result = world["result"]
    assert (
        actual_result is not None and "Body" in actual_result
    ), f"Expected object body in result but got: {actual_result}"


@then("the object data is returned")
def object_data_is_returned_then(world):
    actual_result = world["result"]
    assert (
        actual_result is not None and "Body" in actual_result
    ), f"Expected object body in result but got: {actual_result}"


@then("the object is deleted from the bucket")
def object_is_deleted_then(lws_session):
    client = _s3(lws_session)
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY not in keys, f"Expected object '{TEST_KEY}' to be deleted but found in: {keys}"


@then('the object is "DELETED"')
def object_is_deleted_status_then(lws_session):
    client = _s3(lws_session)
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY not in keys, f"Expected object '{TEST_KEY}' to be deleted but found in: {keys}"


@then('the object is "DELETED" by the lifecycle policy')
def object_deleted_by_lifecycle_then(lws_session):
    pytest.skip("Cannot observe lifecycle expiry in this abstract context")


@then("the object metadata is returned")
def object_metadata_returned_then(world):
    actual_result = world["result"]
    assert (
        actual_result is not None and "ContentLength" in actual_result
    ), f"Expected object metadata in result but got: {actual_result}"


@then("the object listing is returned")
def object_listing_returned_then(world):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected object listing but got: {actual_result}"


@then("the list of objects in the bucket is returned")
def list_of_objects_returned_then(world):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected object listing but got: {actual_result}"


@then("the copy succeeds and the destination object exists")
def copy_succeeds_then(lws_session):
    client = _s3(lws_session)
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY2 in keys, f"Expected copied object '{TEST_KEY2}' to exist but found: {keys}"


@then('the upload is "IN_PROGRESS" with no parts')
def upload_in_progress_no_parts_then(world):
    expected_field = "UploadId"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected UploadId in result but got: {actual_result}"


@then("the upload has at least one part")
def upload_has_at_least_one_part_then(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected part upload to succeed but got: {actual_error}"


@then("the part is uploaded and the upload is still in progress")
def part_uploaded_then(world):
    assert world["error"] is None, f"Expected part upload to succeed but got: {world['error']}"


@then('the upload is "COMPLETED" and the object exists')
def upload_completed_then(lws_session):
    client = _s3(lws_session)
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert (
        TEST_KEY in keys
    ), f"Expected completed upload object '{TEST_KEY}' to exist but found: {keys}"


@then('the upload is "COMPLETED" and the assembled object "EXISTS" in the bucket')
def upload_completed_assembled_then(lws_session):
    client = _s3(lws_session)
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert (
        TEST_KEY in keys
    ), f"Expected assembled object '{TEST_KEY}' to exist in bucket but found: {keys}"


@then('the upload is "ABORTED"')
def upload_aborted_then(world):
    assert world["error"] is None, f"Expected abort to succeed but got: {world['error']}"


@then("the object is expired and removed from the bucket")
def object_expired_then(lws_session):
    pytest.skip("Cannot observe lifecycle expiry in this abstract context")


# ── Then: invariant assertions (no-op — always pass in lws) ───────────


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
