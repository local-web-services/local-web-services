"""Given: the Lambda function has read an existing parameter and completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has read an existing parameter and completed successfully")
def lambda_read_parameter_succeeded_seq():
    pytest.skip("Cannot trigger Lambda SSM read in lws")
