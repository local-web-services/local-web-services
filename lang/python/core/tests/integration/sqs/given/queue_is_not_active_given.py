"""Given: the "sqs" "queue" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sqs" "queue" was not "ACTIVE"')
def queue_is_not_active_given():
    pytest.skip("Cannot configure lifecycle state in integration test context")
