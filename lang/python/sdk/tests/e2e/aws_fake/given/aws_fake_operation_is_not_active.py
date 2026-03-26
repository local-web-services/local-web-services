"""Given: the operation is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the operation is not "ACTIVE"')
def aws_fake_operation_is_not_active():
    pytest.skip("AWS fake service is not yet available in LwsSession")
