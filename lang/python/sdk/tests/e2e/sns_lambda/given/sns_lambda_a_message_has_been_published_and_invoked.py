"""
Given: a message has been published to an "SNS" topic and asynchronously invoked the subscribed
Lambda function
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function'  # noqa: E501
)
def sns_lambda_a_message_has_been_published_and_invoked():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
