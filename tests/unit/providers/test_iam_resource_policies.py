"""Unit tests for iam_resource_policies."""

from __future__ import annotations

from pathlib import Path

import yaml

from lws.providers._shared.iam_resource_policies import ResourcePolicyStore


class TestResourcePolicyStoreLoad:
    def test_load_from_yaml(self, tmp_path):
        # Arrange
        expected_action = "s3:GetObject"
        policies_yaml = {
            "resource_policies": {
                "s3": {
                    "my-bucket": {
                        "Version": "2012-10-17",
                        "Statement": [
                            {
                                "Effect": "Allow",
                                "Principal": "*",
                                "Action": expected_action,
                                "Resource": "arn:aws:s3:::my-bucket/*",
                            }
                        ],
                    }
                }
            }
        }
        yaml_path = tmp_path / "resource_policies.yaml"
        yaml_path.write_text(yaml.dump(policies_yaml))

        # Act
        store = ResourcePolicyStore(yaml_path)
        actual = store.get_policy("s3", "my-bucket")

        # Assert
        assert actual is not None
        actual_action = actual["Statement"][0]["Action"]
        assert actual_action == expected_action

    def test_missing_file_returns_none(self):
        # Arrange
        path = Path("/nonexistent/resource_policies.yaml")
        store = ResourcePolicyStore(path)

        # Act
        actual = store.get_policy("s3", "my-bucket")

        # Assert
        assert actual is None

    def test_unknown_service_returns_none(self, tmp_path):
        # Arrange
        yaml_path = tmp_path / "resource_policies.yaml"
        yaml_path.write_text(yaml.dump({"resource_policies": {}}))
        store = ResourcePolicyStore(yaml_path)

        # Act
        actual = store.get_policy("nonexistent", "resource")

        # Assert
        assert actual is None

    def test_unknown_resource_returns_none(self, tmp_path):
        # Arrange
        yaml_path = tmp_path / "resource_policies.yaml"
        yaml_path.write_text(yaml.dump({"resource_policies": {"s3": {}}}))
        store = ResourcePolicyStore(yaml_path)

        # Act
        actual = store.get_policy("s3", "nonexistent")

        # Assert
        assert actual is None
