"""E2E test for Lambda update-function-code CLI command."""

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
def handler(event, context):
    return {"statusCode": 200}
"""


@pytest.mark.skipif(not _DOCKER_AVAILABLE, reason="Docker daemon not reachable")
@pytest.mark.skipif(
    not _LAMBDA_IMAGE_AVAILABLE,
    reason="public.ecr.aws/lambda/python:3.12 image not available locally",
)
class TestUpdateFunctionCode:
    def test_update_function_code(self, e2e_port, lws_invoke):
        # Arrange
        function_name = "e2e-upd-code-fn"
        with tempfile.TemporaryDirectory(dir=str(Path.home())) as handler_dir:
            handler_file = Path(handler_dir) / "handler.py"
            handler_file.write_text(_HANDLER_CODE)
            lws_invoke(
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
                ]
            )

        # Act
        with tempfile.TemporaryDirectory(dir=str(Path.home())) as new_handler_dir:
            new_handler_file = Path(new_handler_dir) / "handler.py"
            new_handler_file.write_text(_HANDLER_CODE)
            result = runner.invoke(
                app,
                [
                    "lambda",
                    "update-function-code",
                    "--function-name",
                    function_name,
                    "--code",
                    json.dumps({"Filename": new_handler_dir}),
                    "--port",
                    str(e2e_port),
                ],
            )

        # Assert
        assert result.exit_code == 0, result.output
