"""
When: the Lambda function fails to start an execution because the state machine has been deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails to start an execution because the state machine has been deleted")
def invocation_fails_sm_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
