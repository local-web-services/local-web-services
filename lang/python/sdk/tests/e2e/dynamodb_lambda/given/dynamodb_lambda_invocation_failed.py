"""Given: the Lambda invocation fails and the stream record is retried"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation fails and the stream record is retried")
def dynamodb_lambda_invocation_failed():
    pytest.skip("Cannot represent a failed Lambda invocation as sequence setup in lws")
