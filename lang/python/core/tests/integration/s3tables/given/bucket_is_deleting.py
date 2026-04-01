"""Given: the "s3 tables" "bucket" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "bucket" was "DELETING"')
def bucket_is_deleting():
    pytest.skip(
        "Lifecycle simulation (DELETING bucket state) is not available in integration context"
    )
