"""Given: the table is "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table is "CREATING"')
def table_is_creating():
    pytest.skip(
        "Lifecycle simulation (CREATING table state) is not available in integration context"
    )
