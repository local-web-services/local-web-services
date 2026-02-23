"""Unit tests for IdentityStore.get_boundary."""

from __future__ import annotations

import yaml

from lws.providers._shared.iam_identity_store import IdentityStore


class TestIdentityStoreGetBoundary:
    def test_returns_boundary(self, tmp_path):
        # Arrange
        identities_yaml = {
            "identities": {
                "limited": {
                    "type": "user",
                    "inline_policies": [],
                    "boundary_policy": {
                        "Version": "2012-10-17",
                        "Statement": [{"Effect": "Allow", "Action": "s3:Get*", "Resource": "*"}],
                    },
                }
            }
        }
        yaml_path = tmp_path / "identities.yaml"
        yaml_path.write_text(yaml.dump(identities_yaml))
        store = IdentityStore(yaml_path)

        # Act
        actual = store.get_boundary("limited")

        # Assert
        assert actual is not None
        expected_action = "s3:Get*"
        assert actual["Statement"][0]["Action"] == expected_action

    def test_no_boundary_returns_none(self, tmp_path):
        # Arrange
        identities_yaml = {"identities": {"admin": {"type": "user", "inline_policies": []}}}
        yaml_path = tmp_path / "identities.yaml"
        yaml_path.write_text(yaml.dump(identities_yaml))
        store = IdentityStore(yaml_path)

        # Act
        actual = store.get_boundary("admin")

        # Assert
        assert actual is None
