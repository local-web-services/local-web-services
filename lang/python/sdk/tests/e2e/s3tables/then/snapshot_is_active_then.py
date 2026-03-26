"""Then: the snapshot is "ACTIVE" and the table snapshot count increases"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the snapshot is "ACTIVE" and the table snapshot count increases')
def snapshot_is_active_then():
    pytest.skip("Cannot observe table snapshot state without Iceberg client in lws")
