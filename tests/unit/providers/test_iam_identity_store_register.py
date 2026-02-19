"""Unit tests for IdentityStore.register_identity."""

from __future__ import annotations

from lws.providers._shared.iam_identity_store import IdentityStore


class TestIdentityStoreRegister:
    def test_register_identity_adds_to_store(self):
        # Arrange
        store = IdentityStore(path=None)
        expected_name = "new-user"
        expected_policies = [
            {
                "Version": "2012-10-17",
                "Statement": [{"Effect": "Allow", "Action": "*", "Resource": "*"}],
            }
        ]

        # Act
        store.register_identity(expected_name, inline_policies=expected_policies)

        # Assert
        actual_identity = store.get_identity(expected_name)
        assert actual_identity is not None
        actual_policies = actual_identity.inline_policies
        assert actual_policies == expected_policies

    def test_register_identity_updates_existing(self):
        # Arrange
        store = IdentityStore(path=None)
        name = "existing-user"
        store.register_identity(name, inline_policies=[])
        expected_policies = [{"Version": "2012-10-17", "Statement": []}]

        # Act
        store.register_identity(name, inline_policies=expected_policies)

        # Assert
        actual_identity = store.get_identity(name)
        assert actual_identity is not None
        actual_policies = actual_identity.inline_policies
        assert actual_policies == expected_policies

    def test_register_identity_with_no_policies_creates_empty(self):
        # Arrange
        store = IdentityStore(path=None)
        expected_name = "no-perm-user"

        # Act
        store.register_identity(expected_name)

        # Assert
        actual_identity = store.get_identity(expected_name)
        assert actual_identity is not None
        actual_policies = actual_identity.inline_policies
        assert actual_policies == []
