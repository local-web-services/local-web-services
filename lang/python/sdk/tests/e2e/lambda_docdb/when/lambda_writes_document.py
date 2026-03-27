"""When: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when('the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds')
def lambda_writes_document(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
