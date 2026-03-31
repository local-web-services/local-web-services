"""When: a "step functions" "state machine" deletion is finalized"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "step functions" "state machine" deletion is finalized')
def finalize_delete_state_machine(world):
    pytest.skip("Cannot trigger internal state machine finalization event")
