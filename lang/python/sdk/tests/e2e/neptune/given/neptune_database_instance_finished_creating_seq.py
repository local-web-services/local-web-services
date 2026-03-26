"""Given: a database instance has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance has finished creating")
def neptune_database_instance_finished_creating_seq():
    pytest.skip("Cannot trigger internal Neptune instance creation completion in lws")
