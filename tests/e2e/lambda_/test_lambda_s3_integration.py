"""E2E test for Lambda -> S3 path-style addressing integration."""

from __future__ import annotations

import json
import subprocess
import tempfile
from pathlib import Path

import pytest
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

_DOCKER_AVAILABLE = True
try:
    subprocess.run(["docker", "info"], capture_output=True, timeout=5, check=True)
except (subprocess.CalledProcessError, FileNotFoundError, subprocess.TimeoutExpired):
    _DOCKER_AVAILABLE = False

_LAMBDA_IMAGE_AVAILABLE = False
if _DOCKER_AVAILABLE:
    try:
        result = subprocess.run(
            ["docker", "images", "-q", "public.ecr.aws/lambda/python:3.12"],
            capture_output=True,
            timeout=5,
            text=True,
        )
        _LAMBDA_IMAGE_AVAILABLE = bool(result.stdout.strip())
    except (subprocess.CalledProcessError, FileNotFoundError, subprocess.TimeoutExpired):
        pass

_HANDLER_CODE = """\
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


@pytest.mark.skipif(not _DOCKER_AVAILABLE, reason="Docker daemon not reachable")
@pytest.mark.skipif(
    not _LAMBDA_IMAGE_AVAILABLE,
    reason="public.ecr.aws/lambda/python:3.12 image not available locally",
)
class TestLambdaS3Integration:
    def test_lambda_writes_to_s3(self, e2e_port, lws_invoke, assert_invoke, parse_output):
        # Arrange
        bucket_name = "e2e-lambda-s3-bucket"
        object_key = "e2e-lambda-output.txt"
        expected_body = "hello from lambda"
        function_name = "e2e-s3-writer"

        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])

        with tempfile.TemporaryDirectory(dir=str(Path.home())) as handler_dir:
            handler_file = Path(handler_dir) / "handler.py"
            handler_file.write_text(_HANDLER_CODE)

            create_result = runner.invoke(
                app,
                [
                    "lambda",
                    "create-function",
                    "--function-name",
                    function_name,
                    "--runtime",
                    "python3.12",
                    "--handler",
                    "handler.handler",
                    "--code",
                    json.dumps({"Filename": handler_dir}),
                    "--timeout",
                    "30",
                    "--port",
                    str(e2e_port),
                ],
            )
            assert create_result.exit_code == 0, create_result.output

            # Act
            event_payload = json.dumps(
                {"bucket": bucket_name, "key": object_key, "body": expected_body}
            )
            invoke_result = runner.invoke(
                app,
                [
                    "lambda",
                    "invoke",
                    "--function-name",
                    function_name,
                    "--event",
                    event_payload,
                    "--port",
                    str(e2e_port),
                ],
            )

        # Assert
        assert invoke_result.exit_code == 0, invoke_result.output
        actual_result = parse_output(invoke_result.output)
        assert actual_result.get("statusCode") == 200

        outfile = Path(tempfile.mktemp(suffix=".txt"))
        try:
            verify_result = runner.invoke(
                app,
                [
                    "s3api",
                    "get-object",
                    "--bucket",
                    bucket_name,
                    "--key",
                    object_key,
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
