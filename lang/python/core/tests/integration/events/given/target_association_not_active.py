"""Given: the target association is not active."""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target association was not "ACTIVE"')
def target_association_not_active():
    pytest.skip("Cannot configure target association as inactive in integration test context")
