"""AWS CloudFormation in-memory state."""

from __future__ import annotations


class _CfnState:
    """In-memory store for CloudFormation stacks."""

    def __init__(self) -> None:
        self._stacks: dict[str, dict] = {}

    @property
    def stacks(self) -> dict[str, dict]:
        """Return the stacks store keyed by stack name."""
        return self._stacks

    def reset(self) -> None:
        """Reset all state to empty."""
        self._stacks = {}
