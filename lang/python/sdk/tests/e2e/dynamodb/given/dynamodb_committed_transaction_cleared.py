"""Given: a committed transaction has been cleared"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a committed transaction has been cleared")
def dynamodb_committed_transaction_cleared():
    pytest.skip("Cannot trigger transaction clearing as sequence setup in lws")
