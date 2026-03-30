"""Given: the namespace is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the namespace is "DELETING"')
def namespace_is_deleting():
    pytest.skip(
        "Lifecycle simulation (DELETING namespace state) is not available in integration context"
    )
