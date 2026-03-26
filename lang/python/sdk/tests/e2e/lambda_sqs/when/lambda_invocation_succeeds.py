"""When: the Lambda invocation completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda invocation completes successfully")
def lambda_invocation_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation success in lws")
