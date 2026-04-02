"""Then: the "lambda" "invocation" will be "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "invocation" will be "FAILED"')
def sns_lambda_invocation_is_failed():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
