"""Given: throttling was not "ENABLED" for the "api gateway" "prod stage" """

from __future__ import annotations

from pytest_bdd import given


@given('throttling was not "ENABLED" for the "api gateway" "prod stage"')
def throttling_not_enabled_prod():
    """No-op: no throttling configured by default."""
