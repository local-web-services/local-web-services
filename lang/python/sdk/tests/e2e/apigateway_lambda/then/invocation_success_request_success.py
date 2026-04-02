"""Then: the "lambda" "invocation" will be "SUCCESS" and the "api gateway" "request" will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "lambda" "invocation" will be "SUCCESS" and the "api gateway" "request" will be "SUCCESS"'
)
def invocation_success_request_success():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
