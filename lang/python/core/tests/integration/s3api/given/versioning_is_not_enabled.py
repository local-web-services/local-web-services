"""Given: versioning is not enabled"""

from __future__ import annotations

from pytest_bdd import given


@given("versioning is not enabled")
def versioning_is_not_enabled():
    """No-op: versioning is disabled by default."""
