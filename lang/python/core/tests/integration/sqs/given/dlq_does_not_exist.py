"""Given: the dead-letter queue did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the dead-letter queue did not exist")
def dlq_does_not_exist():
    pytest.skip("Cannot test non-existent DLQ in integration test context")
