"""Given: a "SQS" send-message task is configured on the state machine"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "SQS" send-message task is configured on the state machine')
def sqs_send_message_task_configured_given():
    pytest.skip("Cannot pre-set an SQS task configuration state for sequence setup")
