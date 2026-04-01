"""Given: a "cognito" "group" is created in an active "cognito" "user pool" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "cognito" "group" is created in an active "cognito" "user pool"')
def cognito_idp_group_has_been_created():
    pytest.skip("Cannot configure Cognito user pool groups in lws")
