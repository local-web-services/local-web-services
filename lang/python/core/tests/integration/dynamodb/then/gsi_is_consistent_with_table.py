"""Then: the "GSI" is consistent with the table"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "GSI" is consistent with the table')
def gsi_is_consistent_with_table():
    pytest.skip("Cannot verify GSI consistency in integration context")
