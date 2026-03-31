"""When: a "s3 tables" "snapshot" is created for a "s3 tables" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "s3 tables" "snapshot" is created for a "s3 tables" "table"')
def create_snapshot(world: dict):
    pytest.skip("Snapshot management is not available in integration context")
