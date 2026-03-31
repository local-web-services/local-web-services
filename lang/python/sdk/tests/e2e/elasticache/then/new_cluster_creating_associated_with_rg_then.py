"""Then: a new "elasticache" "cluster" will be in "CREATING" state and associated with the "elasticache" "replication group" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'a new "elasticache" "cluster" will be in "CREATING" state and associated with the "elasticache" "replication group"'
)
def new_cluster_creating_associated_with_rg_then():
    pytest.skip("Cannot observe internal replica creation in lws")
