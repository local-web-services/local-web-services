"""Given: no "AVAILABLE" "sns" "message" existed on the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "AVAILABLE" "sns" "message" existed on the "sns" "topic"')
def no_available_message_on_topic():
    pytest.skip("Cannot reliably check for no messages on SNS topic")
