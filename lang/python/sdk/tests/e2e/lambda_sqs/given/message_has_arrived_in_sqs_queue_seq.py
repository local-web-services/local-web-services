"""Given: a message has arrived in the "SQS" queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a message has arrived in the "SQS" queue')
def message_has_arrived_in_sqs_queue_seq():
    pytest.skip("Cannot trigger internal SQS message arrival in lws")
