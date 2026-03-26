"""Given: the cluster is "SNAPSHOTTING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is "SNAPSHOTTING"')
def cluster_is_snapshotting_given():
    pytest.skip("Cannot observe SNAPSHOTTING cluster state in lws")
