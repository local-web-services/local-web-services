"""Given: the "documentdb" "cluster" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" was "DELETING"')
def cluster_is_deleting_given():
    pytest.skip("Cannot observe DELETING cluster state in lws")
