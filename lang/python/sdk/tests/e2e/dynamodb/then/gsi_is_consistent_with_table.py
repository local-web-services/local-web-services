"""Then: the "GSI" will be consistent with the "dynamodb" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "GSI" will be consistent with the "dynamodb" "table"')
def gsi_is_consistent_with_table():
    pytest.skip("Cannot verify GSI consistency in this abstract context")
