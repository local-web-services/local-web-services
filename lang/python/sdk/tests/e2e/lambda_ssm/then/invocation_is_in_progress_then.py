"""Then: the invocation is "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import then


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    expected_state = "IN_PROGRESS"
    # Act
    actual_state = lws_session.get_injected_state("lambda", "invocation", invocation_id)
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
