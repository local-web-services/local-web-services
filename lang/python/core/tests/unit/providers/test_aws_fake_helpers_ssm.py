from __future__ import annotations

import json

from lws.providers._shared.aws_fake_helpers import expand_helpers


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
        assert actual_response.status == 200, f"Expected {200!r} but got {actual_response.status!r}"
        assert actual_response.content_type == expected_content_type, (
            f"Expected {expected_content_type!r} but got {actual_response.content_type!r}"
        )
        assert actual_param["Name"] == expected_name, (
            f'Expected {expected_name!r} but got {actual_param["Name"]!r}'
        )
        assert actual_param["Value"] == expected_value, (
            f'Expected {expected_value!r} but got {actual_param["Value"]!r}'
        )
        assert actual_param["Type"] == expected_type, (
            f'Expected {expected_type!r} but got {actual_param["Type"]!r}'
        )
        assert actual_param["Version"] == 1, f'Expected {1!r} but got {actual_param["Version"]!r}'
        assert "ARN" in actual_param, f'Expected {"ARN"!r} to be in {actual_param!r}'
