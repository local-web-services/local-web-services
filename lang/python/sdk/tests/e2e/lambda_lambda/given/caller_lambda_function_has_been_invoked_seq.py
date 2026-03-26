"""Given: the caller Lambda function has been invoked"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the caller Lambda function has been invoked")
def caller_lambda_function_has_been_invoked_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")
