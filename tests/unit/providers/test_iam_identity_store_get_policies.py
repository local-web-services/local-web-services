"""Unit tests for IdentityStore.get_policies."""

from __future__ import annotations

import yaml

from lws.providers._shared.iam_identity_store import IdentityStore


class TestIdentityStoreGetPolicies:
    def test_returns_inline_policies(self, tmp_path):
        # Arrange
        expected_action = "s3:GetObject"
        identities_yaml = {
            "identities": {
                "reader": {
                    "type": "user",
                    "inline_policies": [
                        {
                            "name": "read",
                            "document": {
                                "Version": "2012-10-17",
                                "Statement": [
                                    {"Effect": "Allow", "Action": expected_action, "Resource": "*"}
                                ],
                            },
                        }
                    ],
                }
            }
        }
        yaml_path = tmp_path / "identities.yaml"
        yaml_path.write_text(yaml.dump(identities_yaml))
        store = IdentityStore(yaml_path)

        # Act
        actual_policies = store.get_policies("reader")

        # Assert
        assert len(actual_policies) == 1
        actual_action = actual_policies[0]["Statement"][0]["Action"]
        assert actual_action == expected_action

    def test_unknown_identity_returns_empty(self, tmp_path):
        # Arrange
        yaml_path = tmp_path / "identities.yaml"
        yaml_path.write_text(yaml.dump({"identities": {}}))
        store = IdentityStore(yaml_path)

        # Act
        actual = store.get_policies("unknown")

        # Assert
        assert actual == []
