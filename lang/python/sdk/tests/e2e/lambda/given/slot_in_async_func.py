"""Given: slot in async_func"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("slot in async_func")
def slot_in_async_func():
    pytest.skip("Cannot observe Lambda async slot state in lws")
