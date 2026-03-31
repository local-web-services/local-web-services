"""When: an expired s3 tables snapshot is removed from a "s3 tables" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an expired s3 tables snapshot is removed from a "s3 tables" "table"')
def expire_snapshot(lws_session, world):
    pytest.skip("Cannot expire a table snapshot without Iceberg client in lws")
