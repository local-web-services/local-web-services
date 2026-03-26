"""When: the Lambda function is invoked"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
