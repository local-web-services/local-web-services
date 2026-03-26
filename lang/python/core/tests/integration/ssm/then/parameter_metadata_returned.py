"""Then: the parameter metadata is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the parameter metadata is returned")
def parameter_metadata_returned(world):
    assert (
        world["error"] is None
    ), f"Expected describe_parameters to succeed but got: {world['error']}"
    assert "Parameters" in world["result"], "Expected 'Parameters' key in response"
