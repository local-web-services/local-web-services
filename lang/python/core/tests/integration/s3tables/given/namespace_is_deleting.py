"""Given: the "s3 tables" "namespace" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "namespace" was "DELETING"')
def namespace_is_deleting():
    pytest.skip(
        "Lifecycle simulation (DELETING namespace state) is not available in integration context"
    )
