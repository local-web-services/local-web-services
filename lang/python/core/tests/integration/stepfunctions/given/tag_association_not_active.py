"""Given: the tag association was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the tag association was not "ACTIVE"')
def tag_association_not_active():
    pytest.skip("Cannot configure tag association as inactive in integration test context")
