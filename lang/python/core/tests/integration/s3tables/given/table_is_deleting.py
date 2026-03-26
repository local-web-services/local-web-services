"""Given: the table is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table is "DELETING"')
def table_is_deleting():
    pytest.skip(
        "Lifecycle simulation (DELETING table state) is not available in integration context"
    )
