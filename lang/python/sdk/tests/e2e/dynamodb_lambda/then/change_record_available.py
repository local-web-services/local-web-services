"""Then: a "dynamodb" "change record" will be "AVAILABLE" for the "lambda" "event source mapping" to process"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'a "dynamodb" "change record" will be "AVAILABLE" for the "lambda" "event source mapping" to process'
)
def change_record_available(lws_session, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected table change to succeed but got: {actual_error}"
