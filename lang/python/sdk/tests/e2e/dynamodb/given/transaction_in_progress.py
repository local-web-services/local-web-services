"""Given: a transaction is currently in progress"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a transaction is currently in progress")
def transaction_in_progress():
    pytest.skip("Cannot force a transaction in-progress in this abstract context")
