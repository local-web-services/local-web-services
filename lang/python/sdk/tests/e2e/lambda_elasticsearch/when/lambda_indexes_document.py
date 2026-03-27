"""When: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when('the Lambda function indexes a document into the "AVAILABLE" domain and succeeds')
def lambda_indexes_document(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
