"""Given: the cluster is "STARTING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is "STARTING"')
def cluster_is_starting_given():
    pytest.skip("Cannot observe STARTING cluster state in lws")
