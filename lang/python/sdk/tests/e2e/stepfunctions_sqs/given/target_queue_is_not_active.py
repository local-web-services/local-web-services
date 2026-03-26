"""Given: the target queue is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target queue is not "ACTIVE"')
def target_queue_is_not_active():
    pytest.skip(
        "lws does not reject start_execution when the target SQS queue is not ACTIVE"
        " (service task dispatch is fire-and-forget)"
    )
