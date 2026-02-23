from __future__ import annotations

import json

from lws.providers._shared.aws_mock_helpers import expand_helpers


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
        assert actual_response.status == 200
        assert actual_response.content_type == expected_content_type
        assert actual_body["output"] == expected_output
        assert actual_body["status"] == expected_status
        assert "executionArn" in actual_body
