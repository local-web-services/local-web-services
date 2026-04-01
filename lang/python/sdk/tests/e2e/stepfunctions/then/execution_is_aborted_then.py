"""Then: the execution will be "ABORTED" """

from __future__ import annotations

from pytest_bdd import then


@then('the execution will be "ABORTED"')
def execution_is_aborted_then(lws_session, world):
    assert world["error"] is None, f"Expected stop_execution to succeed but got: {world['error']}"
    execution_arn = world.get("execution_arn", "")
    resp = lws_session.client("stepfunctions").describe_execution(executionArn=execution_arn)
    expected_status = "ABORTED"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected execution status '{expected_status}' but got '{actual_status}'"
