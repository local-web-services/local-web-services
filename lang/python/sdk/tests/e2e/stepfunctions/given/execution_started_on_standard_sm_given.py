"""Given: an execution is started on a standard "step functions" "state machine" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an execution is started on a standard "step functions" "state machine"')
def execution_started_on_standard_sm_given():
    pytest.skip("Cannot pre-set a running execution state for sequence setup")
