"""Then: the capacity limit is respected"""

from __future__ import annotations

from pytest_bdd import then


@then("the capacity limit is respected")
def the_capacity_limit_is_respected(lws_session):
    resp = lws_session.client("cloudtrail").list_trails()
    actual_count = len(resp.get("Trails", []))
    expected_max = 5
    assert (
        actual_count <= expected_max
    ), f"Expected trail count <= {expected_max} but got {actual_count}"
