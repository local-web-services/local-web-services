from __future__ import annotations

import json

from lws.providers._shared.aws_mock_helpers import expand_helpers


class TestCognitoInitiateAuth:
    def test_initiate_auth_returns_authentication_result(self) -> None:
        # Arrange
        helpers = {
            "id_token": "tok1",
            "access_token": "tok2",
            "refresh_token": "tok3",
            "expires_in": 3600,
        }
        expected_id_token = "tok1"
        expected_access_token = "tok2"
        expected_refresh_token = "tok3"
        expected_expires_in = 3600
        expected_content_type = "application/x-amz-json-1.1"
        expected_token_type = "Bearer"

        # Act
        actual_response = expand_helpers("cognito-idp", "initiate-auth", helpers)

        # Assert
        actual_body = json.loads(actual_response.body)
        actual_auth = actual_body["AuthenticationResult"]
        assert actual_response.status == 200
        assert actual_response.content_type == expected_content_type
        assert actual_auth["IdToken"] == expected_id_token
        assert actual_auth["AccessToken"] == expected_access_token
        assert actual_auth["RefreshToken"] == expected_refresh_token
        assert actual_auth["ExpiresIn"] == expected_expires_in
        assert actual_auth["TokenType"] == expected_token_type
