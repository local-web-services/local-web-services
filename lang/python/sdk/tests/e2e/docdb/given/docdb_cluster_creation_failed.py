"""Given: a "documentdb" "cluster" creation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "documentdb" "cluster" creation fails')
def docdb_cluster_creation_failed():
    pytest.skip("Cannot represent a failed DocumentDB cluster creation as sequence setup in lws")
