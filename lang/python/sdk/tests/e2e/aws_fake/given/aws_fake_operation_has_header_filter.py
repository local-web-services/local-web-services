"""Given: the operation has a header filter"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the operation has a header filter")
def aws_fake_operation_has_header_filter():
    pytest.skip("AWS fake service is not yet available in LwsSession")
