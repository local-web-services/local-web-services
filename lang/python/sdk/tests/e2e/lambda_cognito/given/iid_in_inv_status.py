"""Given: iid in inv_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot observe Lambda invocation state in lws")
