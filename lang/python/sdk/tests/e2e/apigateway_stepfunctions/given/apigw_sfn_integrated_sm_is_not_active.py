"""Given: the integrated state machine is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the integrated state machine is not "ACTIVE"')
def apigw_sfn_integrated_sm_is_not_active():
    pytest.skip("Cannot simulate non-ACTIVE integrated state machine in lws")
