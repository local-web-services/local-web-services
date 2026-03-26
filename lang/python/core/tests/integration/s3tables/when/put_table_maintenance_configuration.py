"""When: maintenance configuration is applied to a table"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("maintenance configuration is applied to a table")
def put_table_maintenance_configuration(world: dict):
    pytest.skip("Maintenance configuration is not available in integration context")
