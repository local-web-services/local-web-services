"""Given: writes were not throttled"""

from __future__ import annotations

from pytest_bdd import given


@given("writes were not throttled")
def writes_not_throttled():
    """No-op: no throttling by default."""
