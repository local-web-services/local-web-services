"""When: the caller Lambda function is invoked"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the caller Lambda function is invoked")
def invoke_caller(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
