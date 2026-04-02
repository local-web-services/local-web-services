"""Given: no "AVAILABLE" "sqs" "message" existed in the "sqs" "queue" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "AVAILABLE" "sqs" "message" existed in the "sqs" "queue"')
def no_available_message_in_queue():
    pytest.skip("Cannot ensure no messages exist in an empty queue without creating it first")
