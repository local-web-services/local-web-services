"""Given: an "AWS" fake has been created for a service"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "AWS" fake has been created for a service')
def aws_fake_has_been_created():
    pytest.skip("AWS fake service is not yet available in LwsSession")
