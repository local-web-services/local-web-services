"""Given: a message exceeding its receive count has been moved to the dead-letter queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a message exceeding its receive count has been moved to the dead-letter queue")
def sqs_a_message_exceeding_receive_count_moved_to_dlq():
    pytest.skip("Cannot simulate DLQ move in lws sequence setup")
