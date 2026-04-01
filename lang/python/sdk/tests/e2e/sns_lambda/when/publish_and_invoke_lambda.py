"""
When: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda
function
"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function'
)
def publish_and_invoke_lambda(world):
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
