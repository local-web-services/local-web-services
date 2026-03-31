"""Given: a "neptune" "cluster" neptune snapshot finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "cluster" neptune snapshot finishes creating')
def neptune_snapshot_finished_creating_seq():
    pytest.skip("Cannot trigger internal Neptune snapshot creation completion in lws")
