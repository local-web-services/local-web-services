"""Given: the "glacier" "job" slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "job" slot is not available')
def job_slot_not_available(world):
    pytest.skip(
        "Capacity-dependent state (no job slot) is not supported " "in stateless integration tests."
    )
