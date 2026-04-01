"""Given: the cloudtrail trail was not "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the cloudtrail trail was not "DELETED"')
def the_cloudtrail_trail_was_not_deleted():
    """No-op: trail was just created in the previous given step."""
