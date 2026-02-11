"""Unit tests for output_json."""

from __future__ import annotations

import json

from lws.cli.services.client import output_json


class TestOutputJson:
    def test_outputs_to_stdout(self, capsys):
        # Arrange
        expected_value = "value"

        # Act
        output_json({"key": expected_value})
        captured = capsys.readouterr()
        parsed = json.loads(captured.out)
        actual_value = parsed["key"]

        # Assert
        assert actual_value == expected_value
