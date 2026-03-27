"""When: the Lambda function reads an existing parameter and completes successfully"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda function reads an existing parameter and completes successfully")
def invocation_reads_param_succeeds(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
