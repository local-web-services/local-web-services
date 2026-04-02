"""Given: the "cloudtrail" "trail" was not "LOGGING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cloudtrail" "trail" was not "LOGGING"')
def the_cloudtrail_trail_was_not_logging():
    """No-op: freshly created trails are not in LOGGING state."""
