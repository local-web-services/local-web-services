"""Given: oid in op_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("oid in op_status")
def aws_fake_oid_in_op_status():
    pytest.skip("AWS fake service is not yet available in LwsSession")
