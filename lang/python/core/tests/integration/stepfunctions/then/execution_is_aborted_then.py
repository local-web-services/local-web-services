"""Then: the execution is "ABORTED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET


@then('the execution is "ABORTED"')
def execution_is_aborted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected stop_execution to succeed but got: {world['error']}"
    execution_arn = world.get("execution_arn", "")
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DescribeExecution"},
        json={"executionArn": execution_arn},
    )
    expected_status = "ABORTED"
    actual_status = r.json().get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected execution status '{expected_status}' but got '{actual_status}'"
