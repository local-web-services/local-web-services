"""Then: the "ssm" "parameter"s under the path will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "ssm" "parameter"s under the path will be returned')
def parameters_under_path_returned(world):
    assert (
        world["error"] is None
    ), f"Expected get_parameters_by_path to succeed but got: {world['error']}"
    assert "Parameters" in world["result"], "Expected 'Parameters' key in response"
