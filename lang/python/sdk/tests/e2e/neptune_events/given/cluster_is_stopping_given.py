"""Given: the "neptune" "cluster" was "STOPPING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "cluster" was "STOPPING"')
def cluster_is_stopping_given():
    pytest.skip("Cannot trigger internal cluster stopping state in lws")
