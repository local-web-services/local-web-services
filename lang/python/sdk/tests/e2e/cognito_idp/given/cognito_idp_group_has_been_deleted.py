"""Given: a group has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a group has been deleted")
def cognito_idp_group_has_been_deleted():
    pytest.skip("Cannot configure Cognito user pool groups in lws")
