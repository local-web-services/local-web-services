"""Given: a "documentdb" "cluster" restore from documentdb snapshot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "documentdb" "cluster" restore from documentdb snapshot completes')
def docdb_cluster_restore_completed():
    pytest.skip("Cannot represent a completed DocumentDB cluster restore as sequence setup in lws")
