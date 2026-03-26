"""Given: a database snapshot deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database snapshot deletion has completed")
def a_database_snapshot_deletion_has_completed():
    pytest.skip("Cannot trigger internal RDS snapshot deletion completion in lws")
