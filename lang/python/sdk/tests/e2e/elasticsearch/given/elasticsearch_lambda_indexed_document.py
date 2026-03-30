"""Given: the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given('the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded')
def elasticsearch_lambda_indexed_document(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
    # Assert
    world["invocation_id"] = invocation_id
