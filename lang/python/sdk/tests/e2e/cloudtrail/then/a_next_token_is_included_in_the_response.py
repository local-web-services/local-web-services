"""Then: a NextToken is included in the response"""

from __future__ import annotations

from pytest_bdd import then


@then("a NextToken is included in the response")
def a_next_token_is_included_in_the_response(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_next_token = actual_result.get("NextToken")
    assert (
        actual_next_token is not None
    ), "Expected a NextToken in the LookupEvents response but it was absent"
    world["next_token"] = actual_next_token
