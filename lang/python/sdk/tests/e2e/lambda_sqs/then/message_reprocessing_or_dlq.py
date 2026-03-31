"""
Then: if the receive count is below the threshold the message is "AVAILABLE" for reprocessing,
otherwise it is redriven to the dead-letter queue
"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'if the receive count is below the threshold the message will be "AVAILABLE" for reprocessing, otherwise it will be redriven to the dead-letter queue'
)  # noqa: E501
def message_reprocessing_or_dlq(world):
    pytest.skip("Cannot observe Lambda SQS failure handling in lws")
