"""E2E test for Lambda (Node.js SDK v3) → S3 virtual-hosted-style addressing.

Verifies that the dns_rewrite.js hook and virtual-hosted middleware allow
a Node.js Lambda to write to S3 without needing ``forcePathStyle: true``
in the SDK client configuration.
"""

from __future__ import annotations

import subprocess
import tempfile
from pathlib import Path

import httpx
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
            ["docker", "images", "-q", "public.ecr.aws/lambda/nodejs:20"],
            capture_output=True,
            timeout=5,
            text=True,
        )
        _LAMBDA_IMAGE_AVAILABLE = bool(result.stdout.strip())
    except (subprocess.CalledProcessError, FileNotFoundError, subprocess.TimeoutExpired):
        pass

# Node.js handler that uses AWS SDK v3 WITHOUT forcePathStyle.
# This relies on the dns_rewrite.js preload hook and virtual-hosted middleware.
_HANDLER_CODE = """\
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


@pytest.mark.skipif(not _DOCKER_AVAILABLE, reason="Docker daemon not reachable")
@pytest.mark.skipif(
    not _LAMBDA_IMAGE_AVAILABLE,
    reason="public.ecr.aws/lambda/nodejs:20 image not available locally",
)
class TestLambdaS3NodejsIntegration:
    """Test that Node.js Lambda can write to S3 without forcePathStyle."""

    def test_nodejs_lambda_writes_to_s3(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        bucket_name = "e2e-nodejs-s3-bucket"
        object_key = "e2e-nodejs-output.txt"
        expected_body = "hello from nodejs lambda"
        function_name = "e2e-nodejs-s3-writer"
        lambda_port = e2e_port + 9

        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])

        with tempfile.TemporaryDirectory(dir=str(Path.home())) as handler_dir:
            handler_file = Path(handler_dir) / "index.js"
            handler_file.write_text(_HANDLER_CODE)

            package_file = Path(handler_dir) / "package.json"
            package_file.write_text(_PACKAGE_JSON)

            # Install dependencies
            install_result = subprocess.run(
                ["npm", "install", "--production"],
                cwd=handler_dir,
                capture_output=True,
                timeout=120,
                check=False,
            )
            assert (
                install_result.returncode == 0
            ), f"npm install failed: {install_result.stderr.decode()}"

            # Create the Lambda function
            resp = httpx.post(
                f"http://localhost:{lambda_port}/2015-03-31/functions",
                json={
                    "FunctionName": function_name,
                    "Runtime": "nodejs20.x",
                    "Handler": "index.handler",
                    "Code": {"Filename": handler_dir},
                    "Timeout": 30,
                },
                timeout=30.0,
            )
            assert resp.status_code == 201, f"CreateFunction failed: {resp.text}"

            # Act
            event_payload = {"bucket": bucket_name, "key": object_key, "body": expected_body}
            invoke_resp = httpx.post(
                f"http://localhost:{lambda_port}/2015-03-31/functions/{function_name}/invocations",
                json=event_payload,
                timeout=60.0,
            )

        # Assert
        assert invoke_resp.status_code == 200, invoke_resp.text
        actual_result = invoke_resp.json()
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
