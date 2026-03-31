"""Given: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue'
)
def running_execution_sent_sqs_message_given():
    pytest.skip("Cannot pre-set a completed execution SQS task state for sequence setup")
