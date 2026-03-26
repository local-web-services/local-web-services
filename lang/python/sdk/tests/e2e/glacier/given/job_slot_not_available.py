"""Given: the job slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the job slot is not available")
def job_slot_not_available():
    pytest.skip("Cannot exhaust job slot limit in lws")
