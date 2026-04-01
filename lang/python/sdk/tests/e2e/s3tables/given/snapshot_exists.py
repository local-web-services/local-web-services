"""Given: the "s3 tables" "snapshot" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "snapshot" existed')
def snapshot_exists():
    pytest.skip("Cannot create a snapshot as a precondition in this context")
