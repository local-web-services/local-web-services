"""Given: the Lambda function has sent a message to the "SQS" queue during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda function has sent a message to the "SQS" queue during invocation')
def lambda_sent_message_to_sqs_seq():
    pytest.skip("Cannot trigger Lambda SQS send in lws")
