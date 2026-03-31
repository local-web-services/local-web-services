"""Given: transaction_status is '"PENDING"'"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("transaction_status is '\"PENDING\"'")
def dynamodb_transaction_status_pending():
    pytest.skip("Cannot force a PENDING transaction as sequence setup in lws")
