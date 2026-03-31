"""When: the "lambda" "function" publishes a message to the "sns" "topic" during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" "function" publishes a message to the "sns" "topic" during invocation')
def lambda_publishes_to_topic(world):
    pytest.skip("Cannot trigger Lambda SNS publish in lws")
