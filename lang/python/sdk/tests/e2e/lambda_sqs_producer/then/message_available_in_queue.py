"""Then: the "sqs" "message" will be "AVAILABLE" in the "sqs" "queue" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "sqs" "message" will be "AVAILABLE" in the "sqs" "queue"')
def message_available_in_queue(world):
    pytest.skip("Cannot observe Lambda SQS send result in lws")
