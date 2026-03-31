"""Given: the "step functions" "state machine" was "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "step functions" "state machine" was "ACTIVE"')
def execution_of_sm_has_been_started():
    pytest.skip("Cannot pre-set a running execution state for sequence setup")
