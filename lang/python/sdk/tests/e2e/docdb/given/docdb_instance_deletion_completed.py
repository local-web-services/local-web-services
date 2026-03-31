"""Given: a "documentdb" "instance" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "documentdb" "instance" deletion completes')
def docdb_instance_deletion_completed():
    pytest.skip(
        "Cannot represent a completed DocumentDB instance deletion as sequence setup in lws"
    )
