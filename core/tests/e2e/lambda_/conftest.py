"""Shared fixtures for lambda_ E2E tests."""

from __future__ import annotations

import json
import subprocess
import tempfile
from pathlib import Path

import pytest
from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

# ── Docker / image availability checks ────────────────────────────────


def _check_docker_available() -> bool:
    for _ in range(3):
        try:
            subprocess.run(["docker", "info"], capture_output=True, timeout=10, check=True)
            return True
        except (
            subprocess.CalledProcessError,
            FileNotFoundError,
            subprocess.TimeoutExpired,
        ):
            import time

            time.sleep(1)
    return False


def _check_image_available(image: str) -> bool:
    try:
        result = subprocess.run(
            ["docker", "images", "-q", image],
            capture_output=True,
            timeout=10,
            text=True,
        )
        return bool(result.stdout.strip())
    except (
        subprocess.CalledProcessError,
        FileNotFoundError,
        subprocess.TimeoutExpired,
    ):
        return False


_DOCKER_AVAILABLE = _check_docker_available()
_PYTHON_IMAGE_AVAILABLE = (
    _check_image_available("public.ecr.aws/lambda/python:3.12") if _DOCKER_AVAILABLE else False
)
_NODEJS_IMAGE_AVAILABLE = (
    _check_image_available("public.ecr.aws/lambda/nodejs:20") if _DOCKER_AVAILABLE else False
)


def pytest_collection_modifyitems(config, items):
    for item in items:
        if "requires_docker" in item.keywords:
            if not _DOCKER_AVAILABLE:
                item.add_marker(pytest.mark.skip(reason="Docker daemon not reachable"))
            elif not _PYTHON_IMAGE_AVAILABLE:
                item.add_marker(
                    pytest.mark.skip(
                        reason="public.ecr.aws/lambda/python:3.12 image not available locally"
                    )
                )
        if "requires_nodejs_image" in item.keywords:
            if not _DOCKER_AVAILABLE:
                item.add_marker(pytest.mark.skip(reason="Docker daemon not reachable"))
            elif not _NODEJS_IMAGE_AVAILABLE:
                item.add_marker(
                    pytest.mark.skip(
                        reason="public.ecr.aws/lambda/nodejs:20 image not available locally"
                    )
                )


# ── Handler code constants ─────────────────────────────────────────────

_PYTHON_HANDLER_CODE = """\
def handler(event, context):
    return {"statusCode": 200}
"""

_S3_HANDLER_CODE = """\
import boto3
import os

def handler(event, context):
    s3 = boto3.client("s3")
    s3.put_object(
        Bucket=event["bucket"],
        Key=event["key"],
        Body=event.get("body", "hello from lambda").encode(),
    )
    return {"statusCode": 200, "bucket": event["bucket"], "key": event["key"]}
"""

_NODEJS_HANDLER_CODE = """\
const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");

exports.handler = async (event) => {
  const client = new S3Client({});
  await client.send(new PutObjectCommand({
    Bucket: event.bucket,
    Key: event.key,
    Body: event.body || "hello from nodejs lambda",
  }));
  return { statusCode: 200, bucket: event.bucket, key: event.key };
};
"""

_PACKAGE_JSON = """\
{
  "name": "e2e-s3-nodejs",
  "version": "1.0.0",
  "dependencies": {
    "@aws-sdk/client-s3": "^3.600.0"
  }
}
"""


# ── Fixtures ───────────────────────────────────────────────────────────


@pytest.fixture()
def python_handler_dir():
    """Create a temporary directory with a Python handler file."""
    with tempfile.TemporaryDirectory(dir=str(Path.home())) as d:
        handler_file = Path(d) / "handler.py"
        handler_file.write_text(_PYTHON_HANDLER_CODE)
        yield d


@pytest.fixture()
def s3_handler_dir():
    """Create a temporary directory with an S3-writing Python handler file."""
    with tempfile.TemporaryDirectory(dir=str(Path.home())) as d:
        handler_file = Path(d) / "handler.py"
        handler_file.write_text(_S3_HANDLER_CODE)
        yield d


@pytest.fixture()
def nodejs_handler_dir():
    """Create a temporary directory with a Node.js S3 handler and installed deps."""
    with tempfile.TemporaryDirectory(dir=str(Path.home())) as d:
        handler_file = Path(d) / "index.js"
        handler_file.write_text(_NODEJS_HANDLER_CODE)

        package_file = Path(d) / "package.json"
        package_file.write_text(_PACKAGE_JSON)

        install_result = subprocess.run(
            ["npm", "install", "--production"],
            cwd=d,
            capture_output=True,
            timeout=120,
            check=False,
        )
        assert (
            install_result.returncode == 0
        ), f"npm install failed: {install_result.stderr.decode()}"

        yield d


@pytest.fixture()
def update_code_handler_dir():
    """Create a second temporary directory with Python handler code for update-function-code."""
    with tempfile.TemporaryDirectory(dir=str(Path.home())) as d:
        handler_file = Path(d) / "handler.py"
        handler_file.write_text(_PYTHON_HANDLER_CODE)
        yield d


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse(
        'a function "{name}" was created with runtime "{runtime}" and handler "{handler}"'
    ),
    target_fixture="created_function",
)
def a_function_was_created(name, runtime, handler, python_handler_dir, lws_invoke, e2e_port):
    lws_invoke(
        [
            "lambda",
            "create-function",
            "--function-name",
            name,
            "--runtime",
            runtime,
            "--handler",
            handler,
            "--code",
            json.dumps({"Filename": python_handler_dir}),
            "--timeout",
            "30",
            "--port",
            str(e2e_port),
        ]
    )
    return {"name": name}


@given(
    parsers.parse('a Lambda function "{name}" was created with S3 handler code'),
    target_fixture="created_s3_function",
)
def a_lambda_function_was_created_with_s3_handler(name, s3_handler_dir, lws_invoke, e2e_port):
    lws_invoke(
        [
            "lambda",
            "create-function",
            "--function-name",
            name,
            "--runtime",
            "python3.12",
            "--handler",
            "handler.handler",
            "--code",
            json.dumps({"Filename": s3_handler_dir}),
            "--timeout",
            "30",
            "--port",
            str(e2e_port),
        ]
    )
    return {"name": name}


@given(
    parsers.parse('a Node.js Lambda function "{name}" was created with S3 handler code'),
    target_fixture="created_nodejs_function",
)
def a_nodejs_lambda_function_was_created_with_s3_handler(
    name, nodejs_handler_dir, lws_invoke, e2e_port
):
    lws_invoke(
        [
            "lambda",
            "create-function",
            "--function-name",
            name,
            "--runtime",
            "nodejs20.x",
            "--handler",
            "index.handler",
            "--code",
            json.dumps({"Filename": nodejs_handler_dir}),
            "--timeout",
            "30",
            "--port",
            str(e2e_port),
        ]
    )
    return {"name": name}


@given(
    parsers.parse(
        'an event source mapping was created for function "{name}" with source "{source_arn}"'
    ),
    target_fixture="created_esm",
)
def an_event_source_mapping_was_created(name, source_arn, lws_invoke, e2e_port):
    body = lws_invoke(
        [
            "lambda",
            "create-event-source-mapping",
            "--function-name",
            name,
            "--event-source-arn",
            source_arn,
            "--port",
            str(e2e_port),
        ]
    )
    return {"uuid": body["UUID"]}


@given(
    parsers.parse('an S3 bucket "{bucket}" was created'),
    target_fixture="created_bucket",
)
def an_s3_bucket_was_created(bucket, lws_invoke, e2e_port):
    lws_invoke(["s3api", "create-bucket", "--bucket", bucket, "--port", str(e2e_port)])
    return {"bucket": bucket}


@when(
    parsers.parse(
        'I create event source mapping for function "{name}"'
        ' with source "{source_arn}" and batch size "{batch_size}"'
    ),
    target_fixture="command_result",
)
def i_create_event_source_mapping(name, source_arn, batch_size, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "create-event-source-mapping",
            "--function-name",
            name,
            "--event-source-arn",
            source_arn,
            "--batch-size",
            batch_size,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create function "{name}" with runtime "{runtime}" and handler "{handler}"'),
    target_fixture="command_result",
)
def i_create_function(name, runtime, handler, python_handler_dir, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "create-function",
            "--function-name",
            name,
            "--runtime",
            runtime,
            "--handler",
            handler,
            "--code",
            json.dumps({"Filename": python_handler_dir}),
            "--timeout",
            "30",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete function "{name}"'),
    target_fixture="command_result",
)
def i_delete_function(name, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "delete-function",
            "--function-name",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when("I delete the event source mapping", target_fixture="command_result")
def i_delete_the_event_source_mapping(created_esm, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "delete-event-source-mapping",
            "--uuid",
            created_esm["uuid"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get function "{name}"'),
    target_fixture="command_result",
)
def i_get_function(name, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "get-function",
            "--function-name",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I invoke function "{function_name}"'),
    target_fixture="command_result",
)
def i_invoke_function(function_name, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "invoke",
            "--function-name",
            function_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I invoke function "{function_name}" with event {event_json}'),
    target_fixture="command_result",
)
def i_invoke_function_with_event(function_name, event_json, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "invoke",
            "--function-name",
            function_name,
            "--event",
            event_json,
            "--port",
            str(e2e_port),
        ],
    )


@when("I list event source mappings", target_fixture="command_result")
def i_list_event_source_mappings(e2e_port):
    return runner.invoke(
        app,
        ["lambda", "list-event-source-mappings", "--port", str(e2e_port)],
    )


@when("I list functions", target_fixture="command_result")
def i_list_functions(e2e_port):
    return runner.invoke(
        app,
        ["lambda", "list-functions", "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I update function code for "{name}"'),
    target_fixture="command_result",
)
def i_update_function_code(name, update_code_handler_dir, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "update-function-code",
            "--function-name",
            name,
            "--code",
            json.dumps({"Filename": update_code_handler_dir}),
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I update function configuration for "{name}" with timeout "{timeout}"'),
    target_fixture="command_result",
)
def i_update_function_configuration(name, timeout, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "update-function-configuration",
            "--function-name",
            name,
            "--timeout",
            timeout,
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('S3 object "{key}" in bucket "{bucket}" will contain "{expected_body}"'),
)
def s3_object_will_contain(key, bucket, expected_body, e2e_port):
    outfile = Path(tempfile.mktemp(suffix=".txt"))
    try:
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
        actual_body = outfile.read_text()
        assert actual_body == expected_body
    finally:
        outfile.unlink(missing_ok=True)


@then("the event source mapping will appear in the list")
def the_event_source_mapping_will_appear_in_list(
    command_result, parse_output, assert_invoke, e2e_port
):
    created = parse_output(command_result.output)
    expected_uuid = created["UUID"]
    list_body = assert_invoke(["lambda", "list-event-source-mappings", "--port", str(e2e_port)])
    actual_uuids = [m["UUID"] for m in list_body["EventSourceMappings"]]
    assert expected_uuid in actual_uuids


@then("the invoke output will have status code 200")
def the_invoke_output_will_have_status_code_200(command_result, parse_output):
    actual_result = parse_output(command_result.output)
    expected_status_code = 200
    actual_status_code = actual_result.get("statusCode")
    assert actual_status_code == expected_status_code


@then("the output will contain a UUID")
def the_output_will_contain_a_uuid(command_result, parse_output):
    actual_body = parse_output(command_result.output)
    assert "UUID" in actual_body
    assert actual_body["UUID"]


@then("the output will contain an error message")
def the_output_will_contain_an_error_message(command_result, parse_output):
    actual_body = parse_output(command_result.output)
    assert "Message" in actual_body


# ── Step definitions for new commands ────────────────────────────────

_LAMBDA_ARN_PREFIX = "arn:aws:lambda:us-east-1:000000000000:function"


@given(
    parsers.parse('function "{name}" was tagged with key "{tag_key}" and value "{tag_value}"'),
)
def function_was_tagged(name, tag_key, tag_value, lws_invoke, e2e_port):
    arn = f"{_LAMBDA_ARN_PREFIX}:{name}"
    tags_json = json.dumps({tag_key: tag_value})
    lws_invoke(
        [
            "lambda",
            "tag-resource",
            "--resource",
            arn,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.parse('permission "{sid}" was added to function "{name}"'),
)
def permission_was_added(sid, name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "lambda",
            "add-permission",
            "--function-name",
            name,
            "--statement-id",
            sid,
            "--action",
            "lambda:InvokeFunction",
            "--principal",
            "s3.amazonaws.com",
            "--port",
            str(e2e_port),
        ]
    )


@when(
    parsers.parse('I tag function "{name}" with key "{tag_key}" and value "{tag_value}"'),
    target_fixture="command_result",
)
def i_tag_lambda_function(name, tag_key, tag_value, e2e_port):
    arn = f"{_LAMBDA_ARN_PREFIX}:{name}"
    tags_json = json.dumps({tag_key: tag_value})
    return runner.invoke(
        app,
        [
            "lambda",
            "tag-resource",
            "--resource",
            arn,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I untag function "{name}" removing key "{tag_key}"'),
    target_fixture="command_result",
)
def i_untag_lambda_function(name, tag_key, e2e_port):
    arn = f"{_LAMBDA_ARN_PREFIX}:{name}"
    tag_keys_json = json.dumps([tag_key])
    return runner.invoke(
        app,
        [
            "lambda",
            "untag-resource",
            "--resource",
            arn,
            "--tag-keys",
            tag_keys_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list tags for function "{name}"'),
    target_fixture="command_result",
)
def i_list_tags_lambda(name, e2e_port):
    arn = f"{_LAMBDA_ARN_PREFIX}:{name}"
    return runner.invoke(
        app,
        [
            "lambda",
            "list-tags",
            "--resource",
            arn,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse(
        'I add permission "{sid}" to function "{name}"'
        ' with action "{action}" and principal "{principal}"'
    ),
    target_fixture="command_result",
)
def i_add_permission(sid, name, action, principal, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "add-permission",
            "--function-name",
            name,
            "--statement-id",
            sid,
            "--action",
            action,
            "--principal",
            principal,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I remove permission "{sid}" from function "{name}"'),
    target_fixture="command_result",
)
def i_remove_permission(sid, name, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "remove-permission",
            "--function-name",
            name,
            "--statement-id",
            sid,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get the policy of function "{name}"'),
    target_fixture="command_result",
)
def i_get_policy(name, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "get-policy",
            "--function-name",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get the event source mapping",
    target_fixture="command_result",
)
def i_get_event_source_mapping(created_esm, e2e_port):
    return runner.invoke(
        app,
        [
            "lambda",
            "get-event-source-mapping",
            "--uuid",
            created_esm["uuid"],
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('function "{name}" will appear in list-functions'),
)
def function_will_appear_in_list(name, assert_invoke, e2e_port):
    verify = assert_invoke(["lambda", "list-functions", "--port", str(e2e_port)])
    actual_names = [f["FunctionName"] for f in verify.get("Functions", [])]
    assert name in actual_names


@then(
    parsers.parse('function "{name}" will not appear in list-functions'),
)
def function_will_not_appear_in_list(name, assert_invoke, e2e_port):
    verify = assert_invoke(["lambda", "list-functions", "--port", str(e2e_port)])
    actual_names = [f["FunctionName"] for f in verify.get("Functions", [])]
    assert name not in actual_names


@then(
    parsers.parse('function "{name}" will have timeout {expected_timeout:d}'),
)
def function_will_have_timeout(name, expected_timeout, assert_invoke, e2e_port):
    verify = assert_invoke(
        ["lambda", "get-function", "--function-name", name, "--port", str(e2e_port)]
    )
    actual_timeout = verify["Configuration"]["Timeout"]
    assert actual_timeout == expected_timeout


@then("the event source mapping will not appear in the list")
def the_event_source_mapping_will_not_appear_in_list(created_esm, assert_invoke, e2e_port):
    expected_uuid = created_esm["uuid"]
    list_body = assert_invoke(["lambda", "list-event-source-mappings", "--port", str(e2e_port)])
    actual_uuids = [m["UUID"] for m in list_body["EventSourceMappings"]]
    assert expected_uuid not in actual_uuids


@then(
    parsers.parse('function "{name}" will have tag "{key}" with value "{value}"'),
)
def function_will_have_tag(name, key, value, assert_invoke, e2e_port):
    arn = f"{_LAMBDA_ARN_PREFIX}:{name}"
    verify = assert_invoke(["lambda", "list-tags", "--resource", arn, "--port", str(e2e_port)])
    tags = verify.get("Tags", {})
    actual_value = tags.get(key)
    assert actual_value == value


@then(
    parsers.parse('function "{name}" will not have tag "{key}"'),
)
def function_will_not_have_tag(name, key, assert_invoke, e2e_port):
    arn = f"{_LAMBDA_ARN_PREFIX}:{name}"
    verify = assert_invoke(["lambda", "list-tags", "--resource", arn, "--port", str(e2e_port)])
    tags = verify.get("Tags", {})
    assert key not in tags


@then(
    parsers.parse('function "{name}" will have permission "{sid}" in its policy'),
)
def function_will_have_permission(name, sid, assert_invoke, e2e_port):
    verify = assert_invoke(
        ["lambda", "get-policy", "--function-name", name, "--port", str(e2e_port)]
    )
    policy = json.loads(verify["Policy"])
    actual_sids = [s["Sid"] for s in policy.get("Statement", [])]
    assert sid in actual_sids


@then(
    parsers.parse('function "{name}" will not have permission "{sid}" in its policy'),
)
def function_will_not_have_permission(name, sid, assert_invoke, e2e_port):
    verify = assert_invoke(
        ["lambda", "get-policy", "--function-name", name, "--port", str(e2e_port)]
    )
    policy = json.loads(verify["Policy"])
    actual_sids = [s["Sid"] for s in policy.get("Statement", [])]
    assert sid not in actual_sids
