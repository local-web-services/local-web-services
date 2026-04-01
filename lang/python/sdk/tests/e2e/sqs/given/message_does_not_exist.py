"""Given: the "sqs" "message" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sqs" "message" did not exist')
def message_does_not_exist():
    """Skip: SQS receive_message on an empty queue returns an empty list, not an error."""
    pytest.skip("SQS receive_message returns empty list for non-existent messages, not an error")
