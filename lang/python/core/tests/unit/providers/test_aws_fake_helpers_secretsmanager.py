from __future__ import annotations

import json

from lws.providers._shared.aws_fake_helpers import expand_helpers


class TestSecretsManagerGetSecretValue:
    def test_get_secret_value_returns_secret_string(self) -> None:
        # Arrange
        helpers = {
            "secret_string": '{"user":"admin"}',
            "name": "my-secret",
        }
        expected_secret_string = '{"user":"admin"}'
        expected_name = "my-secret"
        expected_content_type = "application/x-amz-json-1.1"

        # Act
        actual_response = expand_helpers("secretsmanager", "get-secret-value", helpers)

        # Assert
        actual_body = json.loads(actual_response.body)
        assert actual_response.status == 200, f"Expected {200!r} but got {actual_response.status!r}"
        assert actual_response.content_type == expected_content_type, f"Expected {expected_content_type!r} but got {actual_response.content_type!r}"
        assert actual_body["SecretString"] == expected_secret_string, f'Expected {expected_secret_string!r} but got {actual_body["SecretString"]!r}'
        assert actual_body["Name"] == expected_name, f'Expected {expected_name!r} but got {actual_body["Name"]!r}'
        assert "ARN" in actual_body, f'Expected {"ARN"!r} to be in {actual_body!r}'
        assert expected_name in actual_body["ARN"], f'Expected {expected_name!r} to be in {actual_body["ARN"]!r}'
