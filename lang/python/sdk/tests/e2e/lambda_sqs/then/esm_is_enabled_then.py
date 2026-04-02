"""Then: the "lambda" "event source mapping" will be "ENABLED" and will poll the "sqs" "queue" for messages"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "lambda" "event source mapping" will be "ENABLED" and will poll the "sqs" "queue" for messages'
)
def esm_is_enabled_then(world):
    pytest.skip("Cannot observe event source mapping state in lws")
