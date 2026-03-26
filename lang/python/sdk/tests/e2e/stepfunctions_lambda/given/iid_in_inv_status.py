"""Given: iid in inv_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot pre-set an in-flight Lambda invocation state for sequence setup")
