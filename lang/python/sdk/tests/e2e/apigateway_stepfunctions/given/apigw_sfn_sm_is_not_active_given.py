"""Given: the state machine is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the state machine is not "ACTIVE"')
def apigw_sfn_sm_is_not_active_given():
    pytest.skip("Cannot simulate non-ACTIVE state machine in lws")
