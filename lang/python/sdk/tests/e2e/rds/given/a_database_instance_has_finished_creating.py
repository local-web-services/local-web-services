"""Given: a database instance has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance has finished creating")
def a_database_instance_has_finished_creating():
    pytest.skip("Cannot trigger internal RDS instance creation completion in lws")
