"""Then: the cloudtrail trail will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TRAIL


@then('the cloudtrail trail will be "DELETED"')
def the_cloudtrail_trail_will_be_deleted(lws_session):
    ct = lws_session.client("cloudtrail")
    error_raised = False
    try:
        ct.get_trail(Name=TEST_TRAIL)
    except Exception:
        error_raised = True
    assert error_raised, f"Expected trail '{TEST_TRAIL}' to be deleted but it still exists"
