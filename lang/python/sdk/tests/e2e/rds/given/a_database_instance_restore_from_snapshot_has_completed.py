"""Given: a "rds" "instance" restore from "rds" "snapshot" completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "instance" restore from "rds" "snapshot" completes')
def a_database_instance_restore_from_snapshot_has_completed():
    pytest.skip("Cannot trigger internal RDS instance restore completion in lws")
