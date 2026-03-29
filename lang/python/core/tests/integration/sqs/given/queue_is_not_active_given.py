"""Given: the queue is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the queue is not "ACTIVE"')
def queue_is_not_active_given():
    pytest.skip("Cannot configure lifecycle state in integration test context")
