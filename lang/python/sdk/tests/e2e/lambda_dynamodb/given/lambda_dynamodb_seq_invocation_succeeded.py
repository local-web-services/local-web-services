"""Given: the Lambda invocation has completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has completed successfully")
def lambda_dynamodb_seq_invocation_succeeded():
    pytest.skip("Cannot trigger Lambda invocation in lws")
