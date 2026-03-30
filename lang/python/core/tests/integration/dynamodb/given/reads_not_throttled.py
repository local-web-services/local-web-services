"""Given: reads are not throttled"""

from __future__ import annotations

from pytest_bdd import given


@given("reads are not throttled")
def reads_not_throttled():
    """No-op: no throttling by default."""
