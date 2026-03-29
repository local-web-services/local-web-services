"""Given: the message slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the message slot is not available")
def message_slot_not_available():
    pytest.skip("Cannot exhaust the message slot limit in isolated context")
