"""When: the Lambda function fails because the parameter has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails because the parameter has been deleted")
def invocation_fails_param_not_found(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
