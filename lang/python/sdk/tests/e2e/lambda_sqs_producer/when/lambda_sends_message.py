"""When: the Lambda function sends a message to the "SQS" queue during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function sends a message to the "SQS" queue during invocation')
def lambda_sends_message(world):
    pytest.skip("Cannot trigger Lambda SQS send in lws")
