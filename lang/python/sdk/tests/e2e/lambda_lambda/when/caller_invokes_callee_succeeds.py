"""When: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the caller Lambda function invokes the "ACTIVE" callee and the call succeeds')
def caller_invokes_callee_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
