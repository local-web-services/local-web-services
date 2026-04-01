"""Given: the "sqs" "message" was not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sqs" "message" was not "AVAILABLE"')
def message_is_not_available_given():
    pytest.skip("Cannot force a message into a non-AVAILABLE, non-IN_FLIGHT state")
