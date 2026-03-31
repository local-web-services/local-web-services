"""Given: the "memorydb" "cluster" was "RESTORING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "cluster" was "RESTORING"')
def cluster_is_restoring_given():
    pytest.skip("Cannot observe RESTORING cluster state in lws")
