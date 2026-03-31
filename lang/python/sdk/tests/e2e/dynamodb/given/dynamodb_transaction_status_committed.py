"""Given: transaction_status is '"COMMITTED"'"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("transaction_status is " "COMMITTED" "")
def dynamodb_transaction_status_committed():
    pytest.skip("Cannot force a COMMITTED transaction as sequence setup in lws")
