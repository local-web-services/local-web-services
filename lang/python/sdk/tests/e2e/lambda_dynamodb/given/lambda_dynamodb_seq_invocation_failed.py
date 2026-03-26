"""Given: the Lambda invocation has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has failed")
def lambda_dynamodb_seq_invocation_failed():
    pytest.skip("Cannot trigger Lambda invocation in lws")
