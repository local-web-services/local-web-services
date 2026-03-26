"""Given: a snapshot has been created for a table"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a snapshot has been created for a table")
def s3tables_a_snapshot_has_been_created():
    pytest.skip("Cannot create a table snapshot without Iceberg client in lws")
