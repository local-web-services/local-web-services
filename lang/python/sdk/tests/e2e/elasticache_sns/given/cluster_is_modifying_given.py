"""Given: the "elasticache" "cluster" was "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "cluster" was "MODIFYING"')
def cluster_is_modifying_given():
    pytest.skip("Cannot trigger internal cluster modification state in lws")
