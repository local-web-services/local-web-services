"""Given: the "elasticache" "cluster" was not "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "cluster" was not "MODIFYING"')
def cluster_is_not_modifying_given():
    pytest.skip("Cannot control cluster modification state in lws")
