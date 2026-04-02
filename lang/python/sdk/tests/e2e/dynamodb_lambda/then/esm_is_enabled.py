"""Then: the "lambda" "event source mapping" will be "ENABLED" and will poll the stream for change records"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "lambda" "event source mapping" will be "ENABLED" and will poll the stream for change records'
)
def esm_is_enabled(lws_session, world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected event source mapping creation to succeed but got: {actual_error}"
    resp = lws_session.client("lambda").list_event_source_mappings()
    actual_mappings = resp.get("EventSourceMappings", [])
    expected_min_count = 1
    assert (
        len(actual_mappings) >= expected_min_count
    ), f"Expected at least {expected_min_count} event source mapping but found {len(actual_mappings)}"  # noqa: E501
    actual_states = [m.get("State", "") for m in actual_mappings]
    expected_state = "Enabled"
    assert any(
        s == expected_state for s in actual_states
    ), f"Expected at least one mapping with state '{expected_state}' but found states: {actual_states}"  # noqa: E501
