"""Given: the "s3" "bucket" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3" "bucket" was not "ACTIVE"')
def bucket_is_not_active():
    pytest.skip(
        "Lifecycle simulation (non-ACTIVE bucket state) is not available in integration context"
    )
