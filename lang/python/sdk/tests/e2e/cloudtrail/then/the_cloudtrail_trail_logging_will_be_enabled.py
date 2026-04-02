"""Then: the cloudtrail trail logging will be enabled"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TRAIL


@then("the cloudtrail trail logging will be enabled")
@then('the "cloudtrail" "trail" will be "LOGGING"')
def the_cloudtrail_trail_logging_will_be_enabled(lws_session):
    resp = lws_session.client("cloudtrail").get_trail_status(Name=TEST_TRAIL)
    actual_is_logging = resp.get("IsLogging")
    assert actual_is_logging is True, f"Expected IsLogging to be True but got {actual_is_logging}"
