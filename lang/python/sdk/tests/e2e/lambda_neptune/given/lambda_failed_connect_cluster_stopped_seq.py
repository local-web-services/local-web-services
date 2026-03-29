"""Given: the Lambda function has failed to connect because the Neptune cluster is stopped"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given("the Lambda function has failed to connect because the Neptune cluster is stopped")
def lambda_failed_connect_cluster_stopped_seq(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
    # Assert
    world["invocation_id"] = invocation_id
