"""Given: a "documentdb" "cluster" documentdb snapshot deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "documentdb" "cluster" documentdb snapshot deletion completes')
def docdb_snapshot_deletion_completed():
    pytest.skip(
        "Cannot represent a completed DocumentDB snapshot deletion as sequence setup in lws"
    )
