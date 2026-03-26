"""Given: the Lambda function has failed because the secret is pending deletion"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed because the secret is pending deletion")
def lambda_failed_secret_pending_deletion_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")
