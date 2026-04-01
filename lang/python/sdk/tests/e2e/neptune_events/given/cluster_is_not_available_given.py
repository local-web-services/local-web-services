"""Given: the "neptune" "cluster" was not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "cluster" was not "AVAILABLE"')
def cluster_is_not_available_given():
    pytest.skip("Cannot control cluster availability state in lws")
