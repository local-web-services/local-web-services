"""Then: the "cognito" "user" will be "PENDING" and the trigger Lambda will be invoked synchronously"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "cognito" "user" will be "PENDING" and the trigger Lambda will be invoked synchronously')
def user_is_pending_trigger_invoked():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
