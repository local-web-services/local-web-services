"""Then: the cloudtrail trail logging will be disabled"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TRAIL


@then("the cloudtrail trail logging will be disabled")
@then('the "cloudtrail" "trail" logging will be disabled')
def the_cloudtrail_trail_logging_will_be_disabled(lws_session):
    resp = lws_session.client("cloudtrail").get_trail_status(Name=TEST_TRAIL)
    actual_is_logging = resp.get("IsLogging")
    assert actual_is_logging is False, f"Expected IsLogging to be False but got {actual_is_logging}"
