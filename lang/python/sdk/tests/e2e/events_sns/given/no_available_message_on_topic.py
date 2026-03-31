"""Given: no "AVAILABLE" message existed on the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "AVAILABLE" message existed on the topic')
def no_available_message_on_topic():
    pytest.skip("Cannot reliably check for no messages on SNS topic")
