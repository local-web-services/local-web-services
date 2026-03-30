"""Then: the parameters under the path are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the parameters under the path are returned")
def parameters_under_path_returned(world):
    assert (
        world["error"] is None
    ), f"Expected get_parameters_by_path to succeed but got: {world['error']}"
    assert "Parameters" in world["result"], "Expected 'Parameters' key in response"
