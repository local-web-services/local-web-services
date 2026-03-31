"""Given: the "s3 tables" "snapshot" was "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "snapshot" was "ACTIVE"')
def snapshot_is_active():
    pytest.skip("Snapshot lifecycle state is not available in integration context")
