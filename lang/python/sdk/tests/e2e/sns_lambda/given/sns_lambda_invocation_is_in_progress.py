"""Given: an invocation is "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an invocation is "IN_PROGRESS"')
def sns_lambda_invocation_is_in_progress():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
