"""Unit tests for AwsMockRegistry.load_all."""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_mock_registry import AwsMockRegistry


class TestLoadAll:
    def test_no_mocks_directory_returns_empty(self, tmp_path: Path):
        # Arrange
        non_existent_dir = tmp_path / "mocks"
        registry = AwsMockRegistry(non_existent_dir)

        # Act
        actual_configs = registry.load_all()

        # Assert
        assert actual_configs == {}

    def test_one_mock_directory_with_s3_service(self, tmp_path: Path):
        # Arrange
        expected_service = "s3"
        expected_operation = "get-object"
        expected_status = 200
        expected_body = "mocked"

        mocks_dir = tmp_path / "mocks"
        mocks_dir.mkdir()
        mock_dir = mocks_dir / "my-mock"
        mock_dir.mkdir()
        (mock_dir / "config.yaml").write_text("name: my-mock\nservice: s3\nenabled: true\n")
        ops_dir = mock_dir / "operations"
        ops_dir.mkdir()
        (ops_dir / "get_object.yaml").write_text(
            "operations:\n"
            "  - operation: get-object\n"
            "    response:\n"
            "      status: 200\n"
            "      body: mocked\n"
        )
        registry = AwsMockRegistry(mocks_dir)

        # Act
        actual_configs = registry.load_all()

        # Assert
        assert expected_service in actual_configs
        actual_config = actual_configs[expected_service]
        actual_service = actual_config.service
        assert actual_service == expected_service
        assert len(actual_config.rules) == 1
        actual_operation = actual_config.rules[0].operation
        actual_status = actual_config.rules[0].response.status
        actual_body = actual_config.rules[0].response.body
        assert actual_operation == expected_operation
        assert actual_status == expected_status
        assert actual_body == expected_body

    def test_merges_rules_from_multiple_directories_same_service(self, tmp_path: Path):
        # Arrange
        expected_service = "s3"
        expected_rule_count = 2
        expected_first_operation = "get-object"
        expected_second_operation = "put-object"

        mocks_dir = tmp_path / "mocks"
        mocks_dir.mkdir()

        mock_dir_a = mocks_dir / "mock-a"
        mock_dir_a.mkdir()
        (mock_dir_a / "config.yaml").write_text("name: mock-a\nservice: s3\nenabled: true\n")
        ops_dir_a = mock_dir_a / "operations"
        ops_dir_a.mkdir()
        (ops_dir_a / "get_object.yaml").write_text(
            "operations:\n"
            "  - operation: get-object\n"
            "    response:\n"
            "      status: 200\n"
            "      body: from-a\n"
        )

        mock_dir_b = mocks_dir / "mock-b"
        mock_dir_b.mkdir()
        (mock_dir_b / "config.yaml").write_text("name: mock-b\nservice: s3\nenabled: true\n")
        ops_dir_b = mock_dir_b / "operations"
        ops_dir_b.mkdir()
        (ops_dir_b / "put_object.yaml").write_text(
            "operations:\n"
            "  - operation: put-object\n"
            "    response:\n"
            "      status: 200\n"
            "      body: from-b\n"
        )
        registry = AwsMockRegistry(mocks_dir)

        # Act
        actual_configs = registry.load_all()

        # Assert
        assert expected_service in actual_configs
        actual_rules = actual_configs[expected_service].rules
        actual_rule_count = len(actual_rules)
        assert actual_rule_count == expected_rule_count
        actual_operations = [r.operation for r in actual_rules]
        assert expected_first_operation in actual_operations
        assert expected_second_operation in actual_operations
