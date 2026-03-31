"""Then: the invocation will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation will be "SUCCESS"')
def sns_lambda_invocation_is_success():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")
