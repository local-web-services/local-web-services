"""Given: throttling is not enabled for the dev stage"""

from __future__ import annotations

from pytest_bdd import given


@given("throttling is not enabled for the dev stage")
def throttling_not_enabled_dev():
    """No-op: no throttling configured by default."""
