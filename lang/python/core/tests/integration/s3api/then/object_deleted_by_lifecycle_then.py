"""Then: the "s3" "object" will be "DELETED" by the lifecycle policy"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "s3" "object" will be "DELETED" by the lifecycle policy')
def object_deleted_by_lifecycle_then(world):
    pytest.skip("Cannot observe lifecycle expiry in integration test context.")
