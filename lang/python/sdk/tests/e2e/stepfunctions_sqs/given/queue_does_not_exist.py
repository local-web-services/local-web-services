"""Given: the queue does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the queue does not exist")
def queue_does_not_exist():
    pytest.skip("lws does not validate SQS queue existence when configuring a state machine task")
