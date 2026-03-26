"""Given: the Lambda invocation has completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has completed successfully")
def sns_lambda_the_lambda_invocation_has_completed_successfully():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
