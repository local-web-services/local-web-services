"""Given: the "lambda" "function" publishes a message to the "sns" "topic" during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" publishes a message to the "sns" "topic" during invocation')
def lambda_published_message_to_topic_seq():
    pytest.skip("Cannot trigger Lambda SNS publish in lws")
