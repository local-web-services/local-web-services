"""Given: no message slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no message slot is available")
def no_message_slot_available():
    pytest.skip("Cannot exhaust message slot limit")
