from __future__ import annotations

import json

from lws.providers._shared.aws_fake_helpers import expand_helpers


class TestStepFunctionsStartSyncExecution:
    def test_start_sync_execution_returns_execution_result(self) -> None:
        # Arrange
        helpers = {
            "output": '{"ok":true}',
            "status": "SUCCEEDED",
        }
        expected_output = '{"ok":true}'
        expected_status = "SUCCEEDED"
        expected_content_type = "application/x-amz-json-1.0"

        # Act
        actual_response = expand_helpers("stepfunctions", "start-sync-execution", helpers)

        # Assert
        actual_body = json.loads(actual_response.body)
        assert actual_response.status == 200, f"Expected {200!r} but got {actual_response.status!r}"
        assert (
            actual_response.content_type == expected_content_type
        ), f"Expected {expected_content_type!r} but got {actual_response.content_type!r}"
        assert (
            actual_body["output"] == expected_output
        ), f'Expected {expected_output!r} but got {actual_body["output"]!r}'
        assert (
            actual_body["status"] == expected_status
        ), f'Expected {expected_status!r} but got {actual_body["status"]!r}'
        assert (
            "executionArn" in actual_body
        ), f'Expected {"executionArn"!r} to be in {actual_body!r}'
