"""Then: the "s3 tables" "snapshot" will be "ACTIVE" and the "s3 tables" "table" snapshot count will increase"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "s3 tables" "snapshot" will be "ACTIVE" and the "s3 tables" "table" snapshot count will increase'
)
def snapshot_is_active_then():
    pytest.skip("Cannot observe table snapshot state without Iceberg client in lws")
