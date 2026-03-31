"""Given: transaction_status is '"ROLLED_BACK"'"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("transaction_status is '\"ROLLED_BACK\"'")
def dynamodb_transaction_status_rolled_back():
    pytest.skip("Cannot force a ROLLED_BACK transaction as sequence setup in lws")
