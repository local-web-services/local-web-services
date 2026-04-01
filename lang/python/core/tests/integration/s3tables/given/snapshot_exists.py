"""Given: the "documentdb" "snapshot" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "snapshot" existed')
def snapshot_exists():
    pytest.skip("Snapshot management is not available in integration context")
