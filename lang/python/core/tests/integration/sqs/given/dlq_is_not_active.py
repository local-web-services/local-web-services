"""Given: the dead-letter queue is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the dead-letter queue is not "ACTIVE"')
def dlq_is_not_active():
    pytest.skip("Cannot configure lifecycle state in integration test context")
