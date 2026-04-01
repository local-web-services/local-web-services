"""Given: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"')
def sqs_a_message_exceeding_receive_count_moved_to_dlq():
    pytest.skip("Cannot simulate DLQ move in lws sequence setup")
