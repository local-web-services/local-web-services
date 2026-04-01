"""Given: the "glacier" "archive" slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "archive" slot is not available')
def archive_slot_not_available(world):
    pytest.skip(
        "Capacity-dependent state (no archive slot) is not supported "
        "in stateless integration tests."
    )
