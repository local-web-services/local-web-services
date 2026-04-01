"""Given: a message is consumed from the "sqs" "queue" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a message is consumed from the "sqs" "queue"')
def events_sqs_seq_message_consumed():
    pytest.skip("Cannot trigger internal SQS message consumption in lws")
