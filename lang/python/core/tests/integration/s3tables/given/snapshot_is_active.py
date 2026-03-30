"""Given: the snapshot is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the snapshot is "ACTIVE"')
def snapshot_is_active():
    pytest.skip("Snapshot lifecycle state is not available in integration context")
