"""Unit tests for AwsMockRegistry.load_one."""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_mock_registry import AwsMockRegistry


class TestLoadOne:
    def test_returns_none_for_nonexistent_mock(self, tmp_path: Path):
        # Arrange
        mocks_dir = tmp_path / "mocks"
        mocks_dir.mkdir()
        registry = AwsMockRegistry(mocks_dir)

        # Act
        actual_config = registry.load_one("does-not-exist")

        # Assert
        assert actual_config is None

    def test_returns_config_for_existing_mock(self, tmp_path: Path):
        # Arrange
        expected_service = "dynamodb"
        expected_operation = "get-item"

        mocks_dir = tmp_path / "mocks"
        mocks_dir.mkdir()
        mock_dir = mocks_dir / "my-ddb-mock"
        mock_dir.mkdir()
        (mock_dir / "config.yaml").write_text(
            "name: my-ddb-mock\nservice: dynamodb\nenabled: true\n"
        )
        ops_dir = mock_dir / "operations"
        ops_dir.mkdir()
        (ops_dir / "get_item.yaml").write_text(
            "operations:\n"
            "  - operation: get-item\n"
            "    response:\n"
            "      status: 200\n"
            "      body: found\n"
        )
        registry = AwsMockRegistry(mocks_dir)

        # Act
        actual_config = registry.load_one("my-ddb-mock")

        # Assert
        assert actual_config is not None
        actual_service = actual_config.service
        assert actual_service == expected_service
        assert len(actual_config.rules) == 1
        actual_operation = actual_config.rules[0].operation
        assert actual_operation == expected_operation
