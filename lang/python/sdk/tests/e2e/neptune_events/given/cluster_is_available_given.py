"""Given: the "neptune" "cluster" was "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "cluster" was "AVAILABLE"')
def cluster_is_available_given():
    pytest.skip("Cannot observe internal cluster state transitions in lws")
