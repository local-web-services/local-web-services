"""Then: the transaction is cleared"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the transaction is cleared")
def transaction_is_cleared_then(world):
    pytest.skip("Cannot observe transaction clearing in this abstract context")
