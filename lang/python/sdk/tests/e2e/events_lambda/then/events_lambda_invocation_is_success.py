"""Then: the invocation is "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "SUCCESS"')
def events_lambda_invocation_is_success():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
