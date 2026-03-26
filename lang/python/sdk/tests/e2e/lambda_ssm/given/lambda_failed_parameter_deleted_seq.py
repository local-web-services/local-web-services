"""Given: the Lambda function has failed because the parameter has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed because the parameter has been deleted")
def lambda_failed_parameter_deleted_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")
