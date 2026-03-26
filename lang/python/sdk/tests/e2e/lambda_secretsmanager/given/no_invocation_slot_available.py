"""Given: no invocation slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no invocation slot is available")
def no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")
