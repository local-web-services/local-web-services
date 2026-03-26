"""Given: an operation has been removed from an "AWS" fake"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an operation has been removed from an "AWS" fake')
def aws_fake_operation_has_been_removed():
    pytest.skip("AWS fake service is not yet available in LwsSession")
