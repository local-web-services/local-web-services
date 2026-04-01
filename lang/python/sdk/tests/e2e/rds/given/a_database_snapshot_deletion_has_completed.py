"""Given: a "rds" "snapshot" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "snapshot" deletion completes')
def a_database_snapshot_deletion_has_completed():
    pytest.skip("Cannot trigger internal RDS snapshot deletion completion in lws")
