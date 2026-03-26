"""When: the Step Functions execution fails and the "API" returns an error response"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Step Functions execution fails and the "API" returns an error response')
def sfn_execution_fails_apigw(world):
    pytest.skip("Cannot simulate Step Functions execution failure via API Gateway in lws")
