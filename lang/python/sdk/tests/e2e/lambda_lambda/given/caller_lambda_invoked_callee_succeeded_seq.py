"""Given: the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the caller Lambda function has invoked the "ACTIVE" callee and the call succeeded')
def caller_lambda_invoked_callee_succeeded_seq():
    pytest.skip("Cannot trigger Lambda invocation in lws")
