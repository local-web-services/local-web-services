"""Then: the message is "AVAILABLE" in the queue"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the message is "AVAILABLE" in the queue')
def message_available_in_queue(world):
    pytest.skip("Cannot observe Lambda SQS send result in lws")
