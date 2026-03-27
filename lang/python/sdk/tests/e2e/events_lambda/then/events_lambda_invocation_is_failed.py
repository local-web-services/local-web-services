"""Then: the invocation is "FAILED" """

from __future__ import annotations

from pytest_bdd import then


@then('the invocation is "FAILED"')
def events_lambda_invocation_is_failed(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    expected_state = "FAILED"
    # Act
    actual_state = lws_session.get_injected_state("lambda", "invocation", invocation_id)
    # Assert
    assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"
