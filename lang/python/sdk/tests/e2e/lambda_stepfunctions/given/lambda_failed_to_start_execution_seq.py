"""
Given: the Lambda function has failed to start an execution because the state machine has been
deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "the Lambda function has failed to start an execution because the state machine has been deleted"  # noqa: E501
)
def lambda_failed_to_start_execution_seq():
    pytest.skip("Cannot trigger Lambda Step Functions execution failure in lws")
