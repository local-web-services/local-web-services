"""Given: the destination "s3" "bucket" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the destination "s3" "bucket" did not exist')
def destination_bucket_does_not_exist():
    """No-op: we skip scenarios that require a missing destination bucket."""
    pytest.skip("Cannot remove destination bucket after source bucket is created")
