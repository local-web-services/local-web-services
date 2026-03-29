"""Given: versioning is disabled"""

from __future__ import annotations

from pytest_bdd import given


@given("versioning is disabled")
def versioning_is_disabled():
    """No-op: versioning is disabled by default."""
