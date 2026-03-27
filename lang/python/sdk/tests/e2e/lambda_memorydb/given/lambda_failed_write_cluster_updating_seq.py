"""Given: the Lambda function has failed to write because the cluster is updating"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given("the Lambda function has failed to write because the cluster is updating")
def lambda_failed_write_cluster_updating_seq(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
    # Assert
    world["invocation_id"] = invocation_id
