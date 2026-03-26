"""Given: a running execution has transitioned to a terminal state"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has transitioned to a terminal state")
def running_execution_terminal_given():
    pytest.skip("Cannot pre-set a terminal execution state for sequence setup")
