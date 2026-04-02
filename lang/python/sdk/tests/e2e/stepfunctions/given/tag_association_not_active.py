"""Given: the "step functions" "state machine" tag association was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "step functions" "state machine" tag association was not "ACTIVE"')
def tag_association_not_active():
    pytest.skip("Cannot set tag association to inactive in this context")
