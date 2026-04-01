"""Then: the tag will be cleared from the "lambda" "function" """

from __future__ import annotations

from pytest_bdd import then


@then('the tag will be cleared from the "lambda" "function"')
def tag_cleared_from_function(lws_session, world):
    assert world["error"] is None, f"Expected untag_resource to succeed but got: {world['error']}"
