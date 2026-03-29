"""Then: a snapshot is "CREATING" and the cluster is in "BACKING_UP" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('a snapshot is "CREATING" and the cluster is in "BACKING_UP" state')
def snapshot_creating_cluster_backing_up_then():
    pytest.skip("Cannot observe internal Neptune backup state in lws")
