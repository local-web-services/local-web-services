"""Given: the Step Functions execution fails and the "api gateway" "API" returns an error response"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Step Functions execution fails and the "api gateway" "API" returns an error response')
def apigw_sfn_execution_failed():
    pytest.skip("Cannot represent a failed Step Functions execution as sequence setup in lws")
