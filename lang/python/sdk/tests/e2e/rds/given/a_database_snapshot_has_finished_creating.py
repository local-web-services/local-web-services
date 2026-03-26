"""Given: a database snapshot has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database snapshot has finished creating")
def a_database_snapshot_has_finished_creating():
    pytest.skip("Cannot trigger internal RDS snapshot creation completion in lws")
