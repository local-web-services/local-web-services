from __future__ import annotations

import json

from lws.providers._shared.aws_mock_helpers import expand_helpers


class TestSSMGetParameter:
    def test_get_parameter_returns_parameter_dict(self) -> None:
        # Arrange
        helpers = {"name": "/app/key", "value": "myval", "type": "String"}
        expected_name = "/app/key"
        expected_value = "myval"
        expected_type = "String"
        expected_content_type = "application/x-amz-json-1.1"

        # Act
        actual_response = expand_helpers("ssm", "get-parameter", helpers)

        # Assert
        actual_body = json.loads(actual_response.body)
        actual_param = actual_body["Parameter"]
        assert actual_response.status == 200
        assert actual_response.content_type == expected_content_type
        assert actual_param["Name"] == expected_name
        assert actual_param["Value"] == expected_value
        assert actual_param["Type"] == expected_type
        assert actual_param["Version"] == 1
        assert "ARN" in actual_param
