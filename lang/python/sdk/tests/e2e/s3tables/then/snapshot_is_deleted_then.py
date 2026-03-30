"""Then: the snapshot is "DELETED" and the table snapshot count decreases"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the snapshot is "DELETED" and the table snapshot count decreases')
def snapshot_is_deleted_then():
    pytest.skip("Cannot observe table snapshot deletion without Iceberg client in lws")
