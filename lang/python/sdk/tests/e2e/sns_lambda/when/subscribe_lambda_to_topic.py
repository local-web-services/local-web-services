"""When: a "lambda" "function" subscribes to a "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "lambda" "function" subscribes to a "sns" "topic"')
def subscribe_lambda_to_topic(world):
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")
