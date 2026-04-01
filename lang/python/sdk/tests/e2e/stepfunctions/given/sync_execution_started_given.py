"""Given: a synchronous execution is started on an express "step functions" "state machine" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a synchronous execution is started on an express "step functions" "state machine"')
def sync_execution_started_given():
    pytest.skip("Cannot pre-set a running synchronous execution state for sequence setup")
