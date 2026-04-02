"""When: a running "step functions" "execution" transitions to a terminal state"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running "step functions" "execution" transitions to a terminal state')
def execution_step_transition(world):
    pytest.skip(
        "Cannot trigger internal execution step transition event in integration test context"
    )
