"""Then: the invocation is "SUCCESS" """

from __future__ import annotations

from pytest_bdd import then


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    expected_state = "SUCCESS"
    # Act
    actual_state = lws_session.get_injected_state("lambda", "invocation", invocation_id)
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
