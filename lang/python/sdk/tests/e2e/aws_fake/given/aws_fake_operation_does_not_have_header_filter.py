"""Given: the operation does not have a header filter"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the operation does not have a header filter")
def aws_fake_operation_does_not_have_header_filter():
    pytest.skip("AWS fake service is not yet available in LwsSession")
