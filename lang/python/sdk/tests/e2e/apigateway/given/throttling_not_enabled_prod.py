"""Given: throttling is not enabled for the prod stage"""

from __future__ import annotations

from pytest_bdd import given


@given("throttling is not enabled for the prod stage")
def throttling_not_enabled_prod():
    """No-op: no throttling configured by default."""
