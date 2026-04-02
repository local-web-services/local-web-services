"""Given: no "sqs" "message" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "sqs" "message" "slot" was "available"')
def message_slot_not_available():
    pytest.skip("Cannot exhaust the message slot limit in isolated context")
