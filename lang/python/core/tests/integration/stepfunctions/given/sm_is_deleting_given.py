"""Given: the "step functions" "state machine" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "step functions" "state machine" was "DELETING"')
def sm_is_deleting_given(world):
    pytest.skip("Cannot configure state machine in DELETING state in integration test context")
