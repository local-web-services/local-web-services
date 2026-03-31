"""Then: the "s3 tables" "SNAPSHOT" will be "DELETED" and the "s3 tables" "table" s3 tables snapshot count decreases"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "s3 tables" "SNAPSHOT" will be "DELETED" and the "s3 tables" "table" s3 tables snapshot count decreases'
)
def snapshot_is_deleted_then():
    pytest.skip("Cannot observe table snapshot deletion without Iceberg client in lws")
