"""When: the Lambda invocation completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda invocation completes successfully")
def events_lambda_invocation_completes(world):
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
