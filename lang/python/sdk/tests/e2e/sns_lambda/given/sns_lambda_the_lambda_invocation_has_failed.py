"""Given: the Lambda invocation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation fails")
def sns_lambda_the_lambda_invocation_has_failed():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
