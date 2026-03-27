"""When: the Lambda function fails to write because the cluster is updating"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda function fails to write because the cluster is updating")
def invocation_fails_cluster_updating(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
