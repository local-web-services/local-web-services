"""Then: the execution details are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the execution details are returned")
def execution_details_returned(world):
    assert (
        world["error"] is None
    ), f"Expected describe_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"
