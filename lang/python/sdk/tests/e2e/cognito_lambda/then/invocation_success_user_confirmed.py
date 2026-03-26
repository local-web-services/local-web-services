"""Then: the invocation is "SUCCESS" and the user is "CONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "SUCCESS" and the user is "CONFIRMED"')
def invocation_success_user_confirmed():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
