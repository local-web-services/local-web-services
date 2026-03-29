"""When: the Lambda function publishes a message to the "SNS" topic during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function publishes a message to the "SNS" topic during invocation')
def lambda_publishes_to_topic(world):
    pytest.skip("Cannot trigger Lambda SNS publish in lws")
