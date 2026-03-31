"""Given: a message arrives in the "sqs" "queue" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a message arrives in the "sqs" "queue"')
def message_has_arrived_in_sqs_queue_seq():
    pytest.skip("Cannot trigger internal SQS message arrival in lws")
