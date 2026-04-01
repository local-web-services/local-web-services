"""When: a subscriber consumes a message from the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a subscriber consumes a message from the "sns" "topic"')
def consume_message_from_sns(world):
    pytest.skip("Cannot consume internal SNS message delivery in lws")
