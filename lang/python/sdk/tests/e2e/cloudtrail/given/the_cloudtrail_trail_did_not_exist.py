"""Given: the cloudtrail trail did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the cloudtrail trail did not exist")
def the_cloudtrail_trail_did_not_exist():
    """No-op: reset ensures no trail exists before each scenario."""
