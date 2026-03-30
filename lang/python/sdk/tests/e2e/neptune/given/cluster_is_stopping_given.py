"""Given: the cluster is "STOPPING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is "STOPPING"')
def cluster_is_stopping_given():
    pytest.skip("Cannot observe STOPPING cluster state in lws")
