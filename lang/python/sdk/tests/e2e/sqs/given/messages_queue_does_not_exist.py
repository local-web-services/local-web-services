"""Given: the "sqs" "message"'s "sqs" "queue" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sqs" "message"\'s "sqs" "queue" did not exist')
def messages_queue_does_not_exist():
    pytest.skip("Cannot test non-existent queue for message in isolated context")
