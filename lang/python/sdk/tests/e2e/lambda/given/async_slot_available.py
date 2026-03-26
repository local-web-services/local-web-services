"""Given: an async slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an async slot is available")
def async_slot_available():
    pytest.skip("Cannot trigger Lambda async invocation in lws")
