"""Given: a subscriber has consumed a message from the "SNS" topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a subscriber has consumed a message from the "SNS" topic')
def events_sns_seq_message_consumed():
    pytest.skip("Cannot trigger internal SNS message consumption in lws")
