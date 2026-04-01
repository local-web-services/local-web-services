"""Given: the "neptune" "cluster" was not "STOPPING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "cluster" was not "STOPPING"')
def cluster_is_not_stopping_given():
    pytest.skip("Cannot control cluster stopping state in lws")
