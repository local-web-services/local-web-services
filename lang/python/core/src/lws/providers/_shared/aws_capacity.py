"""Capacity slot configuration for AWS service providers.

When slots is None the capacity is unlimited (default behaviour).
When slots is 0 the capacity is exhausted and new resource operations
are rejected.
"""

from __future__ import annotations

from dataclasses import dataclass


@dataclass
class AwsCapacityConfig:
    """Capacity configuration for an AWS service provider.

    When slots is None the capacity is unlimited (default behaviour).
    When slots is 0 the capacity is exhausted and new resource operations
    are rejected.
    """

    slots: int | None = None

    @property
    def is_exhausted(self) -> bool:
        """Return True if the slot limit is set to zero."""
        return self.slots is not None and self.slots == 0

    def reset(self) -> None:
        """Restore unlimited capacity."""
        self.slots = None
