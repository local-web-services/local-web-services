"""Given: the "sqs" "message"'s "sqs" "queue" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the message\'s queue is not "ACTIVE"')
def messages_queue_is_not_active():
    pytest.skip("Cannot configure lifecycle state in integration test context")
