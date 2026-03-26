"""Then: the invocation is "FAILED" and the user is "REJECTED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "FAILED" and the user is "REJECTED"')
def invocation_failed_user_rejected():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
