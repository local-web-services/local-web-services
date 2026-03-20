"""Unit tests for AwsFakeRegistry.load_one."""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_fake_registry import AwsFakeRegistry


class TestLoadOne:
    def test_returns_none_for_nonexistent_fake(self, tmp_path: Path):
        # Arrange
        fakes_dir = tmp_path / "fakes"
        fakes_dir.mkdir()
        registry = AwsFakeRegistry(fakes_dir)

        # Act
        actual_config = registry.load_one("does-not-exist")

        # Assert
        assert actual_config is None, f"Expected None but got {actual_config!r}"

    def test_returns_config_for_existing_fake(self, tmp_path: Path):
        # Arrange
        expected_service = "dynamodb"
        expected_operation = "get-item"

        fakes_dir = tmp_path / "fakes"
        fakes_dir.mkdir()
        fake_dir = fakes_dir / "my-ddb-fake"
        fake_dir.mkdir()
        (fake_dir / "config.yaml").write_text(
            "name: my-ddb-fake\nservice: dynamodb\nenabled: true\n"
        )
        ops_dir = fake_dir / "operations"
        ops_dir.mkdir()
        (ops_dir / "get_item.yaml").write_text(
            "operations:\n"
            "  - operation: get-item\n"
            "    response:\n"
            "      status: 200\n"
            "      body: found\n"
        )
        registry = AwsFakeRegistry(fakes_dir)

        # Act
        actual_config = registry.load_one("my-ddb-fake")

        # Assert
        assert actual_config is not None, "Expected value to be set but was None"
        actual_service = actual_config.service
        assert actual_service == expected_service, f"Expected {expected_service!r} but got {actual_service!r}"
        assert len(actual_config.rules) == 1, f"Expected {1!r} but got {len(actual_config.rules)!r}"
        actual_operation = actual_config.rules[0].operation
        assert actual_operation == expected_operation, f"Expected {expected_operation!r} but got {actual_operation!r}"
