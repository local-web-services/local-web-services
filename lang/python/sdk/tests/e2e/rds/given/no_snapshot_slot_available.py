"""Given: no snapshot slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no snapshot slot is available")
def no_snapshot_slot_available():
    pytest.skip("Cannot exhaust snapshot slot limit in lws")
