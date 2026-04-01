"""Given: no async slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no async slot is available")
def no_async_slot_available():
    pytest.skip("Cannot exhaust Lambda async slot limit in lws")
