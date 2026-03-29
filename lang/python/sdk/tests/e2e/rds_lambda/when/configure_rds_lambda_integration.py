"""When: the "DB" instance is configured with an "IAM" role to invoke the Lambda function"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "DB" instance is configured with an "IAM" role to invoke the Lambda function')
def configure_rds_lambda_integration(world):
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
