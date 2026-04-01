"""Given: an execution of the state machine has been started"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an execution of the state machine has been started")
def execution_of_sm_has_been_started():
    pytest.skip("Cannot pre-set a running execution state for sequence setup")
