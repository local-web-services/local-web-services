"""Given: an expired s3 tables snapshot is removed from a "s3 tables" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an expired s3 tables snapshot is removed from a "s3 tables" "table"')
def s3tables_an_expired_snapshot_has_been_removed():
    pytest.skip("Cannot expire a table snapshot without Iceberg client in lws")
