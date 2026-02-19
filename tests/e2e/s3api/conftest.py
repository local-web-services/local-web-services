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


# ── Step definitions for new commands ────────────────────────────────


@given(
    parsers.parse(
        'tags were set on bucket "{bucket}" with key "{tag_key}" and value "{tag_value}"'
    ),
)
def tags_were_set_on_bucket(bucket, tag_key, tag_value, lws_invoke, e2e_port):
    tagging_json = json.dumps({"TagSet": [{"Key": tag_key, "Value": tag_value}]})
    lws_invoke(
        [
            "s3api",
            "put-bucket-tagging",
            "--bucket",
            bucket,
            "--tagging",
            tagging_json,
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.parse('a policy was set on bucket "{bucket}"'),
)
def a_policy_was_set_on_bucket(bucket, lws_invoke, e2e_port):
    policy = json.dumps(
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "AllowGetObject",
                    "Effect": "Allow",
                    "Principal": "*",
                    "Action": "s3:GetObject",
                    "Resource": f"arn:aws:s3:::{bucket}/*",
                }
            ],
        }
    )
    lws_invoke(
        [
            "s3api",
            "put-bucket-policy",
            "--bucket",
            bucket,
            "--policy",
            policy,
            "--port",
            str(e2e_port),
        ]
    )


@when(
    parsers.parse('I copy object "{key}" in bucket "{bucket}" from source "{copy_source}"'),
    target_fixture="command_result",
)
def i_copy_object(key, bucket, copy_source, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "copy-object",
            "--bucket",
            bucket,
            "--key",
            key,
            "--copy-source",
            copy_source,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete objects "{key1}" and "{key2}" from bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_delete_objects(key1, key2, bucket, e2e_port):
    delete_json = json.dumps({"Objects": [{"Key": key1}, {"Key": key2}]})
    return runner.invoke(
        app,
        [
            "s3api",
            "delete-objects",
            "--bucket",
            bucket,
            "--delete",
            delete_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I put tags on bucket "{bucket}" with key "{tag_key}" and value "{tag_value}"'),
    target_fixture="command_result",
)
def i_put_bucket_tagging(bucket, tag_key, tag_value, e2e_port):
    tagging_json = json.dumps({"TagSet": [{"Key": tag_key, "Value": tag_value}]})
    return runner.invoke(
        app,
        [
            "s3api",
            "put-bucket-tagging",
            "--bucket",
            bucket,
            "--tagging",
            tagging_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get tags from bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_get_bucket_tagging(bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "get-bucket-tagging",
            "--bucket",
            bucket,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete tags from bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_delete_bucket_tagging(bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "delete-bucket-tagging",
            "--bucket",
            bucket,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get the location of bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_get_bucket_location(bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "get-bucket-location",
            "--bucket",
            bucket,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I put a policy on bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_put_bucket_policy(bucket, e2e_port):
    policy = json.dumps(
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "AllowGetObject",
                    "Effect": "Allow",
                    "Principal": "*",
                    "Action": "s3:GetObject",
                    "Resource": f"arn:aws:s3:::{bucket}/*",
                }
            ],
        }
    )
    return runner.invoke(
        app,
        [
            "s3api",
            "put-bucket-policy",
            "--bucket",
            bucket,
            "--policy",
            policy,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get the policy of bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_get_bucket_policy(bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "get-bucket-policy",
            "--bucket",
            bucket,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I put a notification configuration on bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_put_bucket_notification_configuration(bucket, e2e_port):
    config = json.dumps(
        {
            "LambdaFunctionConfigurations": [
                {
                    "LambdaFunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:test",
                    "Events": ["s3:ObjectCreated:*"],
                }
            ]
        }
    )
    return runner.invoke(
        app,
        [
            "s3api",
            "put-bucket-notification-configuration",
            "--bucket",
            bucket,
            "--notification-configuration",
            config,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get the notification configuration of bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_get_bucket_notification_configuration(bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "get-bucket-notification-configuration",
            "--bucket",
            bucket,
            "--port",
            str(e2e_port),
        ],
    )


@given(
    parsers.parse('website configuration was set on bucket "{bucket}" with index "{index_doc}"'),
)
def website_configuration_was_set(bucket, index_doc, lws_invoke, e2e_port):
    config = json.dumps({"IndexDocument": {"Suffix": index_doc}})
    lws_invoke(
        [
            "s3api",
            "put-bucket-website",
            "--bucket",
            bucket,
            "--website-configuration",
            config,
            "--port",
            str(e2e_port),
        ]
    )


@when(
    parsers.parse('I put website configuration on bucket "{bucket}" with index "{index_doc}"'),
    target_fixture="command_result",
)
def i_put_bucket_website(bucket, index_doc, e2e_port):
    config = json.dumps({"IndexDocument": {"Suffix": index_doc}})
    return runner.invoke(
        app,
        [
            "s3api",
            "put-bucket-website",
            "--bucket",
            bucket,
            "--website-configuration",
            config,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get website configuration from bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_get_bucket_website(bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "get-bucket-website",
            "--bucket",
            bucket,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete website configuration from bucket "{bucket}"'),
    target_fixture="command_result",
)
def i_delete_bucket_website(bucket, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "delete-bucket-website",
            "--bucket",
            bucket,
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('bucket "{bucket}" will have website index document "{expected_suffix}"'),
)
def bucket_will_have_website_index_document(
    bucket, expected_suffix, assert_invoke, parse_output, e2e_port
):
    data = assert_invoke(
        ["s3api", "get-bucket-website", "--bucket", bucket, "--port", str(e2e_port)]
    )
    actual_suffix = data["WebsiteConfiguration"]["IndexDocument"]["Suffix"]
    assert actual_suffix == expected_suffix


@then(
    parsers.parse('bucket "{bucket}" will have no website configuration'),
)
def bucket_will_have_no_website_configuration(bucket, e2e_port):
    result = runner.invoke(
        app,
        ["s3api", "get-bucket-website", "--bucket", bucket, "--port", str(e2e_port)],
    )
    # Expect a non-zero exit code or error indicating no website config
    assert result.exit_code != 0 or "NoSuchWebsiteConfiguration" in result.output


@then(
    parsers.parse('the output will contain website index document "{expected_suffix}"'),
)
def the_output_will_contain_website_index_document(expected_suffix, command_result, parse_output):
    data = parse_output(command_result.output)
    actual_suffix = data["WebsiteConfiguration"]["IndexDocument"]["Suffix"]
    assert actual_suffix == expected_suffix


@when(
    "I list parts of the multipart upload",
    target_fixture="command_result",
)
def i_list_parts(multipart_context, e2e_port):
    return runner.invoke(
        app,
        [
            "s3api",
            "list-parts",
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
