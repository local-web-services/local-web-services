"""Given: the "dynamodb" "table" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "dynamodb" "table" was not "ACTIVE"')
def table_is_not_active():
    pytest.skip(
        "Lifecycle simulation (non-ACTIVE table state) is not available in integration context"
    )
