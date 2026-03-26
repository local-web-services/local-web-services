"""Given: the operation is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the operation is "ACTIVE"')
def aws_fake_operation_is_active():
    pytest.skip("AWS fake service is not yet available in LwsSession")
