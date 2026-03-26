"""When: the Lambda function writes an object to the S3 bucket during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function writes an object to the S3 bucket during invocation")
def lambda_writes_object(world):
    pytest.skip("Cannot trigger Lambda object write in lws")
