"""When: the Lambda function uploads an archive to an existing vault and succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda function uploads an archive to an existing vault and succeeds")
def lambda_uploads_archive(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
