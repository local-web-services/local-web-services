"""Given: a database cluster restore from snapshot has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster restore from snapshot has completed")
def docdb_cluster_restore_completed():
    pytest.skip("Cannot represent a completed DocumentDB cluster restore as sequence setup in lws")
