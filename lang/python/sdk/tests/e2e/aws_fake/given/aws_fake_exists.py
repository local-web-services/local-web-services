"""Given: the "AWS" fake exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "AWS" fake exists')
def aws_fake_exists():
    pytest.skip("AWS fake service is not yet available in LwsSession")
