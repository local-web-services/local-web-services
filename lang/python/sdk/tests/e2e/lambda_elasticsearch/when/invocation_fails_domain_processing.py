"""When: the Lambda function fails to write because the domain is processing a config update"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda function fails to write because the domain is processing a config update")
def invocation_fails_domain_processing(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
