"""Given: the namespace is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the namespace is not "ACTIVE"')
def namespace_is_not_active():
    pytest.skip(
        "Lifecycle simulation (non-ACTIVE namespace state) is not available in integration context"
    )
