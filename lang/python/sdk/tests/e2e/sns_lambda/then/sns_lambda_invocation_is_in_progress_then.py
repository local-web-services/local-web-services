"""Then: the "lambda" "invocation" will be "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "invocation" will be "IN_PROGRESS"')
def sns_lambda_invocation_is_in_progress_then():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
