"""Given: an expired snapshot has been removed from a table"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an expired snapshot has been removed from a table")
def s3tables_an_expired_snapshot_has_been_removed():
    pytest.skip("Cannot expire a table snapshot without Iceberg client in lws")
