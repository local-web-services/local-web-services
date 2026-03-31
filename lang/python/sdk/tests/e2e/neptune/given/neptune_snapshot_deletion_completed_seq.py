"""Given: a "neptune" "cluster" neptune snapshot deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "cluster" neptune snapshot deletion completes')
def neptune_snapshot_deletion_completed_seq():
    pytest.skip("Cannot trigger internal Neptune snapshot deletion completion in lws")
