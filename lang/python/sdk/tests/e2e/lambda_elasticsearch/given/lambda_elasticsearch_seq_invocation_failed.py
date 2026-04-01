"""
Given: the Lambda function has failed to write because the domain is processing a config update
"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given(
    'the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update'
)
def lambda_elasticsearch_seq_invocation_failed(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
    # Assert
    world["invocation_id"] = invocation_id
