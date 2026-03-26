"""Given: no document slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no document slot is available")
def no_document_slot_available():
    pytest.skip("Cannot exhaust document slot limit")
