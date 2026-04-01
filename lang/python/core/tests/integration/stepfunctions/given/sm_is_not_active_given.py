"""Given: the "step functions" "state machine" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "step functions" "state machine" was not "ACTIVE"')
def sm_is_not_active_given(world):
    pytest.skip("Cannot configure state machine in non-ACTIVE state in integration test context")
