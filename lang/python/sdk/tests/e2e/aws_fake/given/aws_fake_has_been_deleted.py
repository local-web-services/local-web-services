"""Given: an "AWS" fake has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "AWS" fake has been deleted')
def aws_fake_has_been_deleted():
    pytest.skip("AWS fake service is not yet available in LwsSession")
