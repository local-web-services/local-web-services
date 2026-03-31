"""Given: a "documentdb" "cluster" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "documentdb" "cluster" deletion completes')
def docdb_cluster_deletion_completed():
    pytest.skip("Cannot represent a completed DocumentDB cluster deletion as sequence setup in lws")
