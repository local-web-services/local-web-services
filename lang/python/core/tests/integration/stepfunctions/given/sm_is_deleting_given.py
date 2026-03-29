"""Given: the state machine is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the state machine is "DELETING"')
def sm_is_deleting_given(world):
    pytest.skip("Cannot configure state machine in DELETING state in integration test context")
