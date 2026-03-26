"""When: an operation is removed from an "AWS" fake"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an operation is removed from an "AWS" fake')
def remove_operation_from_aws_fake():
    pytest.skip("AWS fake service is not yet available in LwsSession")
