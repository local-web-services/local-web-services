"""Given: no "glacier" "job" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "glacier" "job" "slot" was "available"')
def glacier_no_job_slot_available():
    pytest.skip("Glacier provider does not implement capacity checking")
