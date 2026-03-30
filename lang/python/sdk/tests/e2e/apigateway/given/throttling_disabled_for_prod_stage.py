"""Given: throttling has been disabled for the prod stage"""

from __future__ import annotations

from pytest_bdd import given


@given("throttling has been disabled for the prod stage")
def throttling_disabled_for_prod_stage():
    """No-op: throttling is disabled by default."""
