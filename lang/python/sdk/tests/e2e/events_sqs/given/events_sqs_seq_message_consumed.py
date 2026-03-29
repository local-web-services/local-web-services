"""Given: a message has been consumed from the "SQS" queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a message has been consumed from the "SQS" queue')
def events_sqs_seq_message_consumed():
    pytest.skip("Cannot trigger internal SQS message consumption in lws")
