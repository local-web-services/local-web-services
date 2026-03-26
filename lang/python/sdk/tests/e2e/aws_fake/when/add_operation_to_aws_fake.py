"""When: an operation is added to an "AWS" fake"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an operation is added to an "AWS" fake')
def add_operation_to_aws_fake():
    pytest.skip("AWS fake service is not yet available in LwsSession")
