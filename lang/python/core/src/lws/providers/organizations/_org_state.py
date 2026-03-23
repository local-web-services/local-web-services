"""AWS Organizations in-memory state classes."""

from __future__ import annotations

import uuid

_ACCOUNT_ID = "000000000000"


def _next_org_id() -> str:
    """Generate a new Organization ID in the form 'o-' + 12 hex chars."""
    return "o-" + uuid.uuid4().hex[:12]


def _next_root_id() -> str:
    """Generate a new Root ID in the form 'r-' + 4 hex chars."""
    return "r-" + uuid.uuid4().hex[:4]


def _next_ou_id() -> str:
    """Generate a new OU ID in the form 'ou-' + 4 hex + '-' + 8 hex."""
    return "ou-" + uuid.uuid4().hex[:4] + "-" + uuid.uuid4().hex[:8]


def _next_policy_id() -> str:
    """Generate a new Policy ID in the form 'p-' + 10 hex chars."""
    return "p-" + uuid.uuid4().hex[:10]


class _OrganizationsState:
    """In-memory store for AWS Organizations resources."""

    def __init__(self) -> None:
        """Initialise empty state."""
        self._organization: dict | None = None
        self._root: dict | None = None
        self._ous: dict[str, dict] = {}
        self._accounts: dict[str, dict] = {}
        self._account_parents: dict[str, str] = {}
        self._policies: dict[str, dict] = {}
        self._policy_attachments: dict[str, set[str]] = {}
        self._next_account_number: int = 1

    @property
    def organization(self) -> dict | None:
        """Return the current organization, or None if not created."""
        return self._organization

    @organization.setter
    def organization(self, value: dict | None) -> None:
        """Set the current organization."""
        self._organization = value

    @property
    def root(self) -> dict | None:
        """Return the root node, or None if the org has not been created."""
        return self._root

    @root.setter
    def root(self, value: dict | None) -> None:
        """Set the root node."""
        self._root = value

    @property
    def ous(self) -> dict[str, dict]:
        """Return the OU store keyed by OU ID."""
        return self._ous

    @property
    def accounts(self) -> dict[str, dict]:
        """Return the accounts store keyed by account ID."""
        return self._accounts

    @property
    def account_parents(self) -> dict[str, str]:
        """Return mapping of account_id to parent_id."""
        return self._account_parents

    @property
    def policies(self) -> dict[str, dict]:
        """Return the policies store keyed by policy ID."""
        return self._policies

    @property
    def policy_attachments(self) -> dict[str, set[str]]:
        """Return mapping of policy_id to set of target IDs."""
        return self._policy_attachments

    def next_account_id(self) -> str:
        """Return the next sequential 12-digit account ID string."""
        account_id = str(self._next_account_number).zfill(12)
        self._next_account_number += 1
        return account_id

    def reset(self) -> None:
        """Reset all state to empty, as if the service was just started."""
        self._organization = None
        self._root = None
        self._ous = {}
        self._accounts = {}
        self._account_parents = {}
        self._policies = {}
        self._policy_attachments = {}
        self._next_account_number = 1
