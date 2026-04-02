"""Given: the "cloudtrail" "trail" was not "LOGGING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cloudtrail" "trail" was not "LOGGING"')
def the_cloudtrail_trail_was_not_logging(world):
    """Signal that the trail is not logging so guard-aware When steps can reject."""
    world["trail_logging"] = False
