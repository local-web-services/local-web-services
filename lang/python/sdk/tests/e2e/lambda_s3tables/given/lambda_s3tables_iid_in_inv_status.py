"""Given: iid in inv_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("iid in inv_status")
def lambda_s3tables_iid_in_inv_status():
    pytest.skip("Cannot create an in-progress invocation in lws")
