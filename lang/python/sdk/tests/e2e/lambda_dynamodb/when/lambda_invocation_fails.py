"""When: the Lambda invocation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda invocation fails")
def lambda_invocation_fails(world):
    pytest.skip("Cannot trigger Lambda invocation failure in lws")
