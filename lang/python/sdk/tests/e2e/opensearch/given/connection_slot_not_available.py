"""Given: the connection slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the connection slot is not available")
def connection_slot_not_available():
    pytest.skip("Cannot exhaust connection slot limit in lws")
