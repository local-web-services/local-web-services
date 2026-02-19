"""Unit tests for IdentityStore loading."""

from __future__ import annotations

from pathlib import Path

import yaml

from lws.providers._shared.iam_identity_store import IdentityStore


class TestIdentityStoreLoad:
    def test_load_from_yaml(self, tmp_path):
        # Arrange
        identities_yaml = {
            "identities": {
                "admin": {
                    "type": "user",
                    "policies": [],
                    "inline_policies": [
                        {
                            "name": "admin-inline",
                            "document": {
                                "Version": "2012-10-17",
                                "Statement": [{"Effect": "Allow", "Action": "*", "Resource": "*"}],
                            },
                        }
                    ],
                    "boundary_policy": None,
                },
                "reader": {
                    "type": "role",
                    "policies": [],
                    "inline_policies": [
                        {
                            "name": "read-only",
                            "document": {
                                "Version": "2012-10-17",
                                "Statement": [
                                    {
                                        "Effect": "Allow",
                                        "Action": "s3:GetObject",
                                        "Resource": "*",
                                    }
                                ],
                            },
                        }
                    ],
                    "boundary_policy": {
                        "Version": "2012-10-17",
                        "Statement": [
                            {"Effect": "Allow", "Action": "s3:GetObject", "Resource": "*"}
                        ],
                    },
                },
            }
        }
        yaml_path = tmp_path / "identities.yaml"
        yaml_path.write_text(yaml.dump(identities_yaml))

        # Act
        store = IdentityStore(yaml_path)
        actual_admin = store.get_identity("admin")
        actual_reader = store.get_identity("reader")

        # Assert
        assert actual_admin is not None
        expected_admin_name = "admin"
        expected_admin_type = "user"
        expected_reader_type = "role"
        assert actual_admin.name == expected_admin_name
        assert actual_admin.type == expected_admin_type
        assert len(actual_admin.inline_policies) == 1
        assert actual_reader is not None
        assert actual_reader.type == expected_reader_type
        assert actual_reader.boundary_policy is not None

    def test_missing_file_returns_empty(self):
        # Arrange
        path = Path("/nonexistent/identities.yaml")

        # Act
        store = IdentityStore(path)
        actual = store.get_identity("anyone")

        # Assert
        assert actual is None

    def test_unknown_identity_returns_none(self, tmp_path):
        # Arrange
        yaml_path = tmp_path / "identities.yaml"
        yaml_path.write_text(yaml.dump({"identities": {}}))
        store = IdentityStore(yaml_path)

        # Act
        actual = store.get_identity("unknown")

        # Assert
        assert actual is None
