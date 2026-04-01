"""Given: the cloudtrail trail did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the cloudtrail trail did not already exist")
def the_cloudtrail_trail_did_not_already_exist():
    """No-op: reset ensures no trail exists before each scenario."""
