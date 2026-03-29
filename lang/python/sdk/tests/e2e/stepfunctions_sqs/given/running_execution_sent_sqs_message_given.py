"""Given: a running execution has reached the "SQS" task state and sent a message to the queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running execution has reached the "SQS" task state and sent a message to the queue')
def running_execution_sent_sqs_message_given():
    pytest.skip("Cannot pre-set a completed execution SQS task state for sequence setup")
