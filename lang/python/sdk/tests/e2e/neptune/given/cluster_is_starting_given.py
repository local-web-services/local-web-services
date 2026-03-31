"""Given: the "neptune" "cluster" was "STARTING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "cluster" was "STARTING"')
def cluster_is_starting_given():
    pytest.skip("Cannot observe STARTING cluster state in lws")
