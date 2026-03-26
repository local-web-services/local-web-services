"""When: the Lambda function reads an existing parameter and completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function reads an existing parameter and completes successfully")
def invocation_reads_param_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
