"""Given: iid in inv_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("iid in inv_status")
def events_lambda_iid_in_inv_status():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
