"""When: the Lambda function writes a record to the MemoryDB cluster during invocation."""

from __future__ import annotations

from pytest_bdd import when


@when('the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation')
def lambda_writes_record(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
