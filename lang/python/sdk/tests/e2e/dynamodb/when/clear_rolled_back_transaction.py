"""When: a rolled-back transaction is cleared"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a rolled-back transaction is cleared")
def clear_rolled_back_transaction(world):
    pytest.skip("Cannot trigger transaction clearing externally in lws")
