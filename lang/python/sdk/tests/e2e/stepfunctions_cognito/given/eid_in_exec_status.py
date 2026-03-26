"""Given: eid in exec_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("eid in exec_status")
def eid_in_exec_status():
    pytest.skip("Cannot pre-set an in-flight execution state for sequence setup")
