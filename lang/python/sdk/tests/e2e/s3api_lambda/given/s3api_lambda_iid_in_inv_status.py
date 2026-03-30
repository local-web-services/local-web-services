"""Given: iid in inv_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("iid in inv_status")
def s3api_lambda_iid_in_inv_status():
    pytest.skip("Cannot observe internal Lambda invocation state via public API")
