from __future__ import annotations

import json

from lws.providers._shared.aws_mock_helpers import expand_helpers


class TestSSMGetParametersByPath:
    def test_get_parameters_by_path_returns_parameters_list(self) -> None:
        # Arrange
        helpers = {
            "parameters": [
                {"name": "/a", "value": "1"},
                {"name": "/b", "value": "2"},
            ]
        }
        expected_count = 2
        expected_first_name = "/a"
        expected_second_value = "2"

        # Act
        actual_response = expand_helpers("ssm", "get-parameters-by-path", helpers)

        # Assert
        actual_body = json.loads(actual_response.body)
        actual_params = actual_body["Parameters"]
        assert actual_response.status == 200
        assert len(actual_params) == expected_count
        assert actual_params[0]["Name"] == expected_first_name
        assert actual_params[1]["Value"] == expected_second_value
