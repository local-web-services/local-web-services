"""Unit tests for output_json."""

from __future__ import annotations

import json

from ldk.cli.services.client import output_json


class TestOutputJson:
    def test_outputs_to_stdout(self, capsys):
        output_json({"key": "value"})
        captured = capsys.readouterr()
        parsed = json.loads(captured.out)
        assert parsed["key"] == "value"
