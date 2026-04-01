"""Given: no cloudtrail trail has been created with that name"""

from __future__ import annotations

from pytest_bdd import given


@given("no cloudtrail trail has been created with that name")
def no_cloudtrail_trail_has_been_created_with_that_name():
    """No-op: reset ensures no trail exists before each scenario."""
