"""Given: group_id in group_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("group_id in group_status")
def cognito_idp_group_id_in_group_status():
    pytest.skip("Cannot configure Cognito user pool groups in lws")
