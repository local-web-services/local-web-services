"""Then: a new cluster is in "CREATING" state and associated with the replication group"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('a new cluster is in "CREATING" state and associated with the replication group')
def new_cluster_creating_associated_with_rg_then():
    pytest.skip("Cannot observe internal replica creation in lws")
