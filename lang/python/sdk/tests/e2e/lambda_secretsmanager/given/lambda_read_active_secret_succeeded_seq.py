"""Given: the Lambda function has read an "ACTIVE" secret and completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda function has read an "ACTIVE" secret and completed successfully')
def lambda_read_active_secret_succeeded_seq():
    pytest.skip("Cannot trigger Lambda Secrets Manager read in lws")
