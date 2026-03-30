"""Given: the snapshot already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the snapshot already exists")
def snapshot_already_exists():
    pytest.skip("Snapshot management is not available in integration context")
