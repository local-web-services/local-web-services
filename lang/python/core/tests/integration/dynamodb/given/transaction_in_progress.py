"""Given: a "dynamodb" "transaction" was currently in progress"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "dynamodb" "transaction" was currently in progress')
def transaction_in_progress():
    pytest.skip("Cannot force a transaction in-progress in integration context")
