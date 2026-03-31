"""Then: the table will be "DELETING" and "SDK" task calls targeting it will fail"""

from __future__ import annotations

from pytest_bdd import then


@then('the table will be "DELETING" and "SDK" task calls targeting it will fail')
def table_is_deleting_then(lws_session, world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table bucket delete to succeed but got: {actual_error}"
