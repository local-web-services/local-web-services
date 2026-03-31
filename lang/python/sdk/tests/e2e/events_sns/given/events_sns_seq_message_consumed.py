"""Given: a subscriber consumes a message from the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a subscriber consumes a message from the "sns" "topic"')
def events_sns_seq_message_consumed():
    pytest.skip("Cannot trigger internal SNS message consumption in lws")
