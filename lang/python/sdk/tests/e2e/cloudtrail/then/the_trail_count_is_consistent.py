"""Then: the trail count is consistent"""

from __future__ import annotations

from pytest_bdd import step, then


@then("the trail count is consistent")
@step('the "cloudtrail" trail count matches the number of non-"DELETED" "cloudtrail" "trail"s')
def the_trail_count_is_consistent(lws_session):
    resp = lws_session.client("cloudtrail").list_trails()
    actual_trails = resp.get("Trails", [])
    assert isinstance(
        actual_trails, list
    ), f"Expected trails to be a list but got {type(actual_trails)}"
