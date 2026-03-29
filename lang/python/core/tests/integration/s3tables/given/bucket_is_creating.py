"""Given: the bucket is "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bucket is "CREATING"')
def bucket_is_creating():
    pytest.skip(
        "Lifecycle simulation (CREATING bucket state) is not available in integration context"
    )
