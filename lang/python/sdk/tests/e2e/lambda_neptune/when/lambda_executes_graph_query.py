"""When: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when('the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds')
def lambda_executes_graph_query(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
