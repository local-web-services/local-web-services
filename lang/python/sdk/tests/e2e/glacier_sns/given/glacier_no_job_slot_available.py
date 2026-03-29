"""Given: no job slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no job slot is available")
def glacier_no_job_slot_available():
    pytest.skip("Glacier provider does not implement capacity checking")
