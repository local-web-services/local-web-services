"""Then: the invocation will be "FAILED" and the "cognito" "user" will be rejected"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation will be "FAILED" and the "cognito" "user" will be rejected')
def invocation_failed_user_rejected():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
