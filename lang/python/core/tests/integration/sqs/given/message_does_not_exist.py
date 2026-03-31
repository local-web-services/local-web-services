"""Given: the "sqs" "message" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sqs" "message" did not exist')
def message_does_not_exist():
    pytest.skip("SQS receive_message returns empty list for non-existent messages, not an error")
