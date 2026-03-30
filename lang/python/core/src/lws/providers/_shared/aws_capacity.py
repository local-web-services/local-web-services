"""Capacity slot configuration for AWS service providers.

When slots is None the capacity is unlimited (default behaviour).
When slots is 0 the capacity is exhausted and new resource operations
are rejected.
"""

from __future__ import annotations

from dataclasses import dataclass

from fastapi import Response
from fastapi.responses import JSONResponse


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


def check_capacity(
    config: AwsCapacityConfig,
    error_code: str = "ServiceUnavailableException",
    status_code: int = 503,
) -> Response | None:
    """Return a JSON error response if capacity is exhausted, otherwise None.

    Args:
        config: The capacity configuration to check.
        error_code: The AWS error code to include in the response body.
        status_code: The HTTP status code for the error response.

    Returns:
        A ``JSONResponse`` when exhausted; ``None`` when capacity is available.
    """
    if config.is_exhausted:
        return JSONResponse(
            content={"__type": error_code, "message": "lws: capacity exhausted"},
            status_code=status_code,
        )
    return None
