"""Then: the invocation is "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "FAILED"')
def events_lambda_invocation_is_failed():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
