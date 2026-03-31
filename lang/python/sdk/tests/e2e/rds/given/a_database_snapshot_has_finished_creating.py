"""Given: a "rds" "snapshot" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "snapshot" finishes creating')
def a_database_snapshot_has_finished_creating():
    pytest.skip("Cannot trigger internal RDS snapshot creation completion in lws")
