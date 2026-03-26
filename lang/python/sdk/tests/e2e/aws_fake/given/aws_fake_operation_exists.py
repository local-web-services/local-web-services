"""Given: the operation exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the operation exists")
def aws_fake_operation_exists():
    pytest.skip("AWS fake service is not yet available in LwsSession")
