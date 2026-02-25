"""Unit tests for AwsFakeRegistry.load_all."""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_fake_registry import AwsFakeRegistry


class TestLoadAll:
    def test_no_fakes_directory_returns_empty(self, tmp_path: Path):
        # Arrange
        non_existent_dir = tmp_path / "fakes"
        registry = AwsFakeRegistry(non_existent_dir)

        # Act
        actual_configs = registry.load_all()

        # Assert
        assert actual_configs == {}

    def test_one_fake_directory_with_s3_service(self, tmp_path: Path):
        # Arrange
        expected_service = "s3"
        expected_operation = "get-object"
        expected_status = 200
        expected_body = "faked"

        fakes_dir = tmp_path / "fakes"
        fakes_dir.mkdir()
        fake_dir = fakes_dir / "my-fake"
        fake_dir.mkdir()
        (fake_dir / "config.yaml").write_text("name: my-fake\nservice: s3\nenabled: true\n")
        ops_dir = fake_dir / "operations"
        ops_dir.mkdir()
        (ops_dir / "get_object.yaml").write_text(
            "operations:\n"
            "  - operation: get-object\n"
            "    response:\n"
            "      status: 200\n"
            "      body: faked\n"
        )
        registry = AwsFakeRegistry(fakes_dir)

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

        fakes_dir = tmp_path / "fakes"
        fakes_dir.mkdir()

        fake_dir_a = fakes_dir / "fake-a"
        fake_dir_a.mkdir()
        (fake_dir_a / "config.yaml").write_text("name: fake-a\nservice: s3\nenabled: true\n")
        ops_dir_a = fake_dir_a / "operations"
        ops_dir_a.mkdir()
        (ops_dir_a / "get_object.yaml").write_text(
            "operations:\n"
            "  - operation: get-object\n"
            "    response:\n"
            "      status: 200\n"
            "      body: from-a\n"
        )

        fake_dir_b = fakes_dir / "fake-b"
        fake_dir_b.mkdir()
        (fake_dir_b / "config.yaml").write_text("name: fake-b\nservice: s3\nenabled: true\n")
        ops_dir_b = fake_dir_b / "operations"
        ops_dir_b.mkdir()
        (ops_dir_b / "put_object.yaml").write_text(
            "operations:\n"
            "  - operation: put-object\n"
            "    response:\n"
            "      status: 200\n"
            "      body: from-b\n"
        )
        registry = AwsFakeRegistry(fakes_dir)

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
