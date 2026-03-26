"""Then: the invocation is "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "IN_PROGRESS"')
def events_lambda_invocation_is_in_progress_then():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
