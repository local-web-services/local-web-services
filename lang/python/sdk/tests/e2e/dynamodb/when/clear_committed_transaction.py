"""When: a committed "dynamodb" "transaction" is cleared"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a committed "dynamodb" "transaction" is cleared')
def clear_committed_transaction(world):
    pytest.skip("Cannot trigger committed transaction clearing externally in lws")
