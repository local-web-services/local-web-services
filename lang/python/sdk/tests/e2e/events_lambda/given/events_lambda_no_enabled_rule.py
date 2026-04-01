"""Given: no "ENABLED" rule existed on the bus targeting a function"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "ENABLED" rule existed on the bus targeting a function')
def events_lambda_no_enabled_rule():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
