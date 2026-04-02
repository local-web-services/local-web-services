"""Given: "dynamodb" "write" throttling was not active"""

from __future__ import annotations

from pytest_bdd import given


@given('"dynamodb" "write" throttling was not active')
def writes_not_throttled():
    """No-op: no throttling by default."""
