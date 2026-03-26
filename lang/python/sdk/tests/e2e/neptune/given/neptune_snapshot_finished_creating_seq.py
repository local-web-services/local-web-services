"""Given: a database cluster snapshot has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster snapshot has finished creating")
def neptune_snapshot_finished_creating_seq():
    pytest.skip("Cannot trigger internal Neptune snapshot creation completion in lws")
