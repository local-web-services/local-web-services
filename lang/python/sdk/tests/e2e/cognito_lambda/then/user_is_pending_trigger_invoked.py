"""Then: the user is "PENDING" and the trigger Lambda is invoked synchronously"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the user is "PENDING" and the trigger Lambda is invoked synchronously')
def user_is_pending_trigger_invoked():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
