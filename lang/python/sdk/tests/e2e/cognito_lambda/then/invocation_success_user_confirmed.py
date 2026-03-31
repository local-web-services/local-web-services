"""Then: the invocation will be "SUCCESS" and the "cognito" "user" will be "CONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation will be "SUCCESS" and the "cognito" "user" will be "CONFIRMED"')
def invocation_success_user_confirmed():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
