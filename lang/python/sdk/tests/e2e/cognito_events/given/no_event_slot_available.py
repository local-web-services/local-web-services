"""Given: no event slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no event slot is available")
def no_event_slot_available():
    pytest.skip("Cannot exhaust event slot limit")
