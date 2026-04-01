"""Given: no record exists"""

from __future__ import annotations

from pytest_bdd import given


@given("no record exists")
def no_record_exists(world):
    """Set a non-existent record ID so DescribeRecord fails."""
    world["record_id"] = "rec-missing"
