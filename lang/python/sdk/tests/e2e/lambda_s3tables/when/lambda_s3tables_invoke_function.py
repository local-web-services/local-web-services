"""When: the Lambda function is invoked"""

from __future__ import annotations

import uuid

from pytest_bdd import when


@when("the Lambda function is invoked")
def lambda_s3tables_invoke_function(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "IN_PROGRESS")
    # Assert
    world["invocation_id"] = invocation_id
