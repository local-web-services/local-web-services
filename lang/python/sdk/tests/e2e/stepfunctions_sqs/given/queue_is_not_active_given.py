"""Given: the queue is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the queue is not "ACTIVE"')
def queue_is_not_active_given():
    pytest.skip(
        "lws does not validate SQS queue lifecycle state when configuring a state machine task"
    )
