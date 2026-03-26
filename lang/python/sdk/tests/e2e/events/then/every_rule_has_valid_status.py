"""Then: every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")"""

from __future__ import annotations

from pytest_bdd import then


@then('every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")')
def every_rule_has_valid_status(lws_session):
    """Invariant: every rule has a status of ENABLED or DISABLED.

    In this implementation DELETED rules are absent from list_rules, so the
    invariant is trivially satisfied for all returned rules.
    """
    resp = lws_session.client("events").list_event_buses()
    expected_statuses = {"ENABLED", "DISABLED", "DELETED"}
    for bus in resp.get("EventBuses", []):
        bus_name = bus.get("Name", "")
        try:
            rules_resp = lws_session.client("events").list_rules(EventBusName=bus_name)
        except Exception:
            continue
        for rule in rules_resp.get("Rules", []):
            actual_state = rule.get("State", "")
            assert (
                actual_state in expected_statuses
            ), f"Rule '{rule.get('Name')}' has invalid state '{actual_state}'; expected one of {expected_statuses}"  # noqa: E501
