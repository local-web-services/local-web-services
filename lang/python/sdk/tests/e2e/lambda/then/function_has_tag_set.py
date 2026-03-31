"""Then: the "lambda" "function" has the tag set"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TAG_KEY, _func_arn


@then('the "lambda" "function" has the tag set')
def function_has_tag_set(lws_session, world):
    assert world["error"] is None, f"Expected tag_resource to succeed but got: {world['error']}"
    resp = lws_session.client("lambda").list_tags(Resource=_func_arn())
    actual_tags = resp.get("Tags", {})
    expected_key = TEST_TAG_KEY
    assert (
        expected_key in actual_tags
    ), f"Expected tag key '{expected_key}' to be set but found: {actual_tags}"
