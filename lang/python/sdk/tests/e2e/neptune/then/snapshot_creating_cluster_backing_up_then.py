"""Then: a neptune snapshot will be "CREATING" and the "neptune" "cluster" will be in "BACKING_UP" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'a neptune snapshot will be "CREATING" and the "neptune" "cluster" will be in "BACKING_UP" state'
)
def snapshot_creating_cluster_backing_up_then():
    pytest.skip("Cannot observe internal Neptune backup state in lws")
