"""Given: no archive slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no archive slot is available")
def no_archive_slot_available():
    pytest.skip("Cannot exhaust archive slot limit")
