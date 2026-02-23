from __future__ import annotations

import json

from lws.providers._shared.aws_mock_helpers import expand_helpers


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
        assert actual_response.status == 200
        assert actual_response.content_type == expected_content_type
        assert actual_body["SecretString"] == expected_secret_string
        assert actual_body["Name"] == expected_name
        assert "ARN" in actual_body
        assert expected_name in actual_body["ARN"]
