"""Given: iid in inv_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("iid in inv_status")
def cognito_lambda_iid_in_inv_status():
    pytest.skip("Cannot represent a completed Lambda invocation as sequence setup in lws")
