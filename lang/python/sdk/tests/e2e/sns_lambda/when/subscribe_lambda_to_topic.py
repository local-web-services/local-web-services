"""When: a Lambda function subscribes to an "SNS" topic"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a Lambda function subscribes to an "SNS" topic')
def subscribe_lambda_to_topic(world):
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")
