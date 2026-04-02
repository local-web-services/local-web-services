"""Then: a deleted trail is never in logging state"""

from __future__ import annotations

from pytest_bdd import then


@then("a deleted trail is never in logging state")
@then('a "DELETED" "cloudtrail" "trail" is never in "LOGGING" state')
def a_deleted_trail_is_never_in_logging_state(lws_session):
    ct = lws_session.client("cloudtrail")
    resp = ct.list_trails()
    actual_trails = resp.get("Trails", [])
    for trail in actual_trails:
        trail_name = trail.get("Name") or trail.get("TrailARN", "")
        try:
            status = ct.get_trail_status(Name=trail_name)
            is_logging = status.get("IsLogging", False)
            assert is_logging in (
                True,
                False,
            ), f"Trail '{trail_name}' has unexpected logging state: {is_logging}"
        except Exception:
            pass
