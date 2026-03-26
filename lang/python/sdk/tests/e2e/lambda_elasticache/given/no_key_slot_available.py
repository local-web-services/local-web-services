"""Given: no key slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no key slot is available")
def no_key_slot_available():
    pytest.skip("Cannot exhaust key slot limit")
