"""Given: a "documentdb" "cluster" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "documentdb" "cluster" modification completes')
def docdb_cluster_modification_completed():
    pytest.skip(
        "Cannot represent a completed DocumentDB cluster modification as sequence setup in lws"
    )
