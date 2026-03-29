"""Given: the snapshot exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the snapshot exists")
def snapshot_exists():
    pytest.skip("Snapshot management is not available in integration context")
