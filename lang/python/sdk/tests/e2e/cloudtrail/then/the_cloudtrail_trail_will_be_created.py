"""Then: the cloudtrail trail will be "CREATED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TRAIL


@then('the cloudtrail trail will be "CREATED"')
@then('the "cloudtrail" "trail" will be "CREATED"')
def the_cloudtrail_trail_will_be_created(lws_session):
    resp = lws_session.client("cloudtrail").get_trail(Name=TEST_TRAIL)
    actual_name = resp["Trail"]["Name"]
    expected_name = TEST_TRAIL
    assert (
        actual_name == expected_name
    ), f"Expected trail name '{expected_name}' but got '{actual_name}'"
