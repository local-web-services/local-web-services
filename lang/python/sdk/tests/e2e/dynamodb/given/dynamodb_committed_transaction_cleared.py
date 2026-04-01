"""Given: a committed transaction is cleared"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a committed transaction is cleared")
def dynamodb_committed_transaction_cleared():
    pytest.skip("Cannot trigger transaction clearing as sequence setup in lws")
