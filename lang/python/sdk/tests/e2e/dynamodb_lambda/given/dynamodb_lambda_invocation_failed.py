"""Given: the Lambda invocation has failed and the stream record has been retried"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has failed and the stream record has been retried")
def dynamodb_lambda_invocation_failed():
    pytest.skip("Cannot represent a failed Lambda invocation as sequence setup in lws")
