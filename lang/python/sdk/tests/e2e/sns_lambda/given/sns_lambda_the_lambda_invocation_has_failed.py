"""Given: the Lambda invocation has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has failed")
def sns_lambda_the_lambda_invocation_has_failed():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
