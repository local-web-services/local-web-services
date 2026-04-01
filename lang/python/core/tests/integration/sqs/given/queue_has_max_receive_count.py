"""Given: the "sqs" "queue" had a maximum receive count configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sqs" "queue" had a maximum receive count configured')
def queue_has_max_receive_count():
    pytest.skip("Cannot configure DLQ redrive policy in integration test context")
