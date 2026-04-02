"""Given: "dynamodb" "read" throttling was not active"""

from __future__ import annotations

from pytest_bdd import given


@given('"dynamodb" "read" throttling was not active')
def reads_not_throttled():
    """No-op: no throttling by default."""
