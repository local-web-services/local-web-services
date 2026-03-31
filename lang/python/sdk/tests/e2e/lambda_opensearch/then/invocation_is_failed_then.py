"""Then: the invocation will be "FAILED" """

from __future__ import annotations

from pytest_bdd import then


@then('the invocation will be "FAILED"')
def invocation_is_failed_then(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id") or "nonexistent-invocation-id"
    expected_state = "FAILED"
    # Act
    actual_state = lws_session.get_injected_state("lambda", "invocation", invocation_id)
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
