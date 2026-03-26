"""Given: the bucket is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bucket is "DELETING"')
def bucket_is_deleting():
    pytest.skip(
        "Lifecycle simulation (DELETING bucket state) is not available in integration context"
    )
