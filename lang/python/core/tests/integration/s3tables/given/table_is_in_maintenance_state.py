"""Given: the "s3 tables" "table" was in "MAINTENANCE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "table" was in "MAINTENANCE" state')
def table_is_in_maintenance_state():
    pytest.skip(
        "Lifecycle simulation (MAINTENANCE table state) is not available in integration context"
    )
