"""Shared fixtures for s3api E2E tests."""

from __future__ import annotations

import json

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a bucket "{bucket}" was created'),
    target_fixture="given_bucket",
)
def a_bucket_was_created(bucket, lws_invoke, e2e_port):
    lws_invoke(["s3api", "create-bucket", "--bucket", bucket, "--port", str(e2e_port)])
    return {"bucket": bucket}


@given(
    parsers.parse('a file was created with content "{content}"'),
    target_fixture="given_file",
)
def a_file_was_created_with_content(content, tmp_path):
    body_file = tmp_path / "upload.txt"
    body_file.write_text(content)
    return {"path": body_file, "content": content}


@given(
    parsers.parse('a multipart upload was created for key "{key}" in bucket "{bucket}"'),
    target_fixture="multipart_context",
)
def a_multipart_upload_was_created(key, bucket, lws_invoke, e2e_port):
    create_body = lws_invoke(
        [
            "s3api",
            "create-multipart-upload",
            "--bucket",
            bucket,
            "--key",
            key,
            "--port",
            str(e2e_port),
        ]
    )
    upload_id = create_body["InitiateMultipartUploadResult"]["UploadId"]
    return {
        "bucket": bucket,
        "key": key,
        "upload_id": upload_id,
        "parts": [],
    }


@given(
    parsers.parse('an object "{key}" was put into bucket "{bucket}" with content "{content}"'),
    target_fixture="given_object",
)
def an_object_was_put(key, bucket, content, tmp_path, lws_invoke, e2e_port):
    body_file = tmp_path / "input.txt"
    body_file.write_text(content)
    lws_invoke(
        [
            "s3api",
            "put-object",
            "--bucket",
            bucket,
            "--key",
            key,
            "--body",
            str(body_file),
            "--port",
            str(e2e_port),
        ]
    )
    return {"bucket": bucket, "key": key, "content": content}


@then(
    parsers.parse('bucket "{bucket}" will exist'),
)
def bucket_will_exist(bucket, assert_invoke, e2e_port):
    assert_invoke(["s3api", "head-bucket", "--bucket", bucket, "--port", str(e2e_port)])


@then(
    parsers.parse('bucket "{bucket}" will have {count:d} objects'),
)
def bucket_will_have_n_objects(bucket, count, assert_invoke, e2e_port):
    verify = assert_invoke(
        ["s3api", "list-objects-v2", "--bucket", bucket, "--port", str(e2e_port)]
    )
    actual_count = verify.get("KeyCount", 0)
    assert actual_count == count


@then(
    parsers.parse('bucket "{bucket}" will not appear in list-buckets'),
)
def bucket_will_not_appear(bucket, assert_invoke, e2e_port):
    verify = assert_invoke(["s3api", "list-buckets", "--port", str(e2e_port)])
    actual_names = [b["Name"] for b in verify.get("Buckets", [])]
    assert bucket not in actual_names


@when(
    "I abort the multipart upload",
    target_fixture="command_result",
)
def i_abort_multipart_upload(multipart_context, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "abort-multipart-upload",
            "--bucket",
            multipart_context["bucket"],
            "--key",
            multipart_context["key"],
            "--upload-id",
            multipart_context["upload_id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I complete the multipart upload",
    target_fixture="command_result",
)
def i_complete_multipart_upload(multipart_context, e2e_port):
    parts_json = json.dumps({"Parts": multipart_context["parts"]})
    return runner.invoke(
        app,
        [
            "s3api",
            "complete-multipart-upload",
            "--bucket",
            multipart_context["bucket"],
            "--key",
            multipart_context["key"],
            "--upload-id",
            multipart_context["upload_id"],
            "--multipart-upload",
            parts_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_create_bucket(bucket, e2e_port):
    return runner.invoke(
        app,
        ["s3api", "create-bucket", "--bucket", bucket, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I create a multipart upload for key "{key}" in bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_create_multipart_upload(key, bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "create-multipart-upload",
            "--bucket",
            bucket,
            "--key",
            key,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_delete_bucket(bucket, e2e_port):
    return runner.invoke(
        app,
        ["s3api", "delete-bucket", "--bucket", bucket, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I delete object "{key}" from bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_delete_object(key, bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "delete-object",
            "--bucket",
            bucket,
            "--key",
            key,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get object "{key}" from bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_get_object(key, bucket, tmp_path, e2e_port):
    outfile = tmp_path / "output.txt"
    result = runner.invoke(
        app,
        [
            "s3api",
            "get-object",
            "--bucket",
            bucket,
            "--key",
            key,
            str(outfile),
            "--port",
            str(e2e_port),
        ],
    )
    # Stash outfile on the result for the then-step to read
    result._outfile = outfile
    return result


@when(
    parsers.parse('I head bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_head_bucket(bucket, e2e_port):
    return runner.invoke(
        app,
        ["s3api", "head-bucket", "--bucket", bucket, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I head object "{key}" in bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_head_object(key, bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "head-object",
            "--bucket",
            bucket,
            "--key",
            key,
            "--port",
            str(e2e_port),
        ],
    )


@when("I list buckets", target_fixture="command_result")
def i_list_buckets(e2e_port):
    return runner.invoke(
        app,
        ["s3api", "list-buckets", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I list objects in bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_list_objects(bucket, e2e_port):
    return runner.invoke(
        app,
        ["s3api", "list-objects-v2", "--bucket", bucket, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I put object "{key}" into bucket "{bucket}" from the file'),
    target_fixture="command_result",
)
def i_put_object(key, bucket, given_file, tmp_path, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "put-object",
            "--bucket",
            bucket,
            "--key",
            key,
            "--body",
            str(given_file["path"]),
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I upload part {part_number:d} with content "{content}"'),
    target_fixture="command_result",
)
def i_upload_part(part_number, content, multipart_context, tmp_path, e2e_port):
    part_file = tmp_path / f"when_part{part_number}.bin"
    part_file.write_bytes(content.encode())
    return runner.invoke(
        app,
        [
            "s3api",
            "upload-part",
            "--bucket",
            multipart_context["bucket"],
            "--key",
            multipart_context["key"],
            "--upload-id",
            multipart_context["upload_id"],
            "--part-number",
            str(part_number),
            "--body",
            str(part_file),
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse(
        'object "{key}" in bucket "{bucket}" will have binary content "{expected_content}"'
    ),
)
def object_will_have_binary_content(key, bucket, expected_content, tmp_path, e2e_port):
    outfile = tmp_path / "verify.bin"
    verify_result = runner.invoke(
        app,
        [
            "s3api",
            "get-object",
            "--bucket",
            bucket,
            "--key",
            key,
            str(outfile),
            "--port",
            str(e2e_port),
        ],
    )
    assert verify_result.exit_code == 0, verify_result.output
    actual_content = outfile.read_bytes()
    assert actual_content == expected_content.encode()


@then(
    parsers.parse('object "{key}" in bucket "{bucket}" will have content "{expected_content}"'),
)
def object_will_have_content(key, bucket, expected_content, tmp_path, e2e_port):
    outfile = tmp_path / "verify.txt"
    verify_result = runner.invoke(
        app,
        [
            "s3api",
            "get-object",
            "--bucket",
            bucket,
            "--key",
            key,
            str(outfile),
            "--port",
            str(e2e_port),
        ],
    )
    assert verify_result.exit_code == 0, verify_result.output
    actual_content = outfile.read_text()
    assert actual_content == expected_content


@given(
    parsers.parse('part {part_number:d} with content "{content}" was uploaded'),
    target_fixture="multipart_context",
)
def part_was_uploaded(
    part_number, content, multipart_context, tmp_path, lws_invoke, parse_output, e2e_port
):
    part_file = tmp_path / f"part{part_number}.bin"
    part_file.write_bytes(content.encode())
    upload_body = lws_invoke(
        [
            "s3api",
            "upload-part",
            "--bucket",
            multipart_context["bucket"],
            "--key",
            multipart_context["key"],
            "--upload-id",
            multipart_context["upload_id"],
            "--part-number",
            str(part_number),
            "--body",
            str(part_file),
            "--port",
            str(e2e_port),
        ]
    )
    etag = upload_body["ETag"]
    multipart_context["parts"].append({"PartNumber": part_number, "ETag": etag})
    return multipart_context


@then(
    parsers.parse('the bucket list will include "{bucket}"'),
)
def the_bucket_list_will_include(bucket, command_result, parse_output):
    data = parse_output(command_result.output)
    buckets = data["ListAllMyBucketsResult"]["Buckets"].get("Bucket", [])
    if isinstance(buckets, dict):
        buckets = [buckets]
    actual_names = [b["Name"] for b in buckets]
    assert bucket in actual_names


@then(
    parsers.parse('the downloaded file will have content "{expected_content}"'),
)
def the_downloaded_file_will_have_content(expected_content, command_result):
    actual_content = command_result._outfile.read_text()
    assert actual_content == expected_content


@then(
    parsers.parse('the object list will include "{key}"'),
)
def the_object_list_will_include(key, command_result, parse_output):
    data = parse_output(command_result.output)
    contents = data["ListBucketResult"].get("Contents", [])
    if isinstance(contents, dict):
        contents = [contents]
    actual_keys = [obj["Key"] for obj in contents]
    assert key in actual_keys


@then(
    parsers.parse('the output will contain "{expected_key}"'),
)
def the_output_will_contain(expected_key, command_result, parse_output):
    data = parse_output(command_result.output)
    assert expected_key in data


@then("the output will contain an ETag")
def the_output_will_contain_etag(command_result, parse_output):
    data = parse_output(command_result.output)
    assert "ETag" in data


@then("the output will contain an upload ID")
def the_output_will_contain_upload_id(command_result, parse_output):
    data = parse_output(command_result.output)
    upload_id = data["InitiateMultipartUploadResult"]["UploadId"]
    assert upload_id
