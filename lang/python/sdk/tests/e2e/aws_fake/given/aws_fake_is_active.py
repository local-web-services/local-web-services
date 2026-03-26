"""Given: the "AWS" fake is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "AWS" fake is "ACTIVE"')
def aws_fake_is_active():
    pytest.skip("AWS fake service is not yet available in LwsSession")
