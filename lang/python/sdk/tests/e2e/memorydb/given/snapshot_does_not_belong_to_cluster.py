"""Given: the "memorydb" "snapshot" does not belong to this "memorydb" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "snapshot" does not belong to this "memorydb" "cluster"')
def snapshot_does_not_belong_to_cluster():
    pytest.skip("Cannot create orphan snapshot in lws")
