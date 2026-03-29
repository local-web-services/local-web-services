"""Given: a database cluster snapshot deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster snapshot deletion has completed")
def neptune_snapshot_deletion_completed_seq():
    pytest.skip("Cannot trigger internal Neptune snapshot deletion completion in lws")
