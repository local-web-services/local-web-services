"""IAM in-memory state classes."""

from __future__ import annotations


class _IamState:
    """In-memory store for IAM resources."""

    def __init__(self) -> None:
        self._roles: dict[str, dict] = {}
        self._role_policies: dict[str, dict[str, str]] = {}  # role -> {policy_name: doc}
        self._attached_policies: dict[str, list[str]] = {}  # role -> [policy_arn]
        self._policies: dict[str, dict] = {}  # arn -> policy
        self._instance_profiles: dict[str, dict] = {}

    @property
    def roles(self) -> dict[str, dict]:
        """Return roles store."""
        return self._roles

    @property
    def role_policies(self) -> dict[str, dict[str, str]]:
        """Return role policies store."""
        return self._role_policies

    @property
    def attached_policies(self) -> dict[str, list[str]]:
        """Return attached policies store."""
        return self._attached_policies

    @property
    def policies(self) -> dict[str, dict]:
        """Return policies store."""
        return self._policies

    @property
    def instance_profiles(self) -> dict[str, dict]:
        """Return instance profiles store."""
        return self._instance_profiles
