"""Given: the "s3 tables" "snapshot" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "snapshot" already existed')
def snapshot_already_exists():
    pytest.skip("Cannot create a snapshot as a precondition in this context")
