"""Then: the "lambda" "invocation" will be "FAILED" and the "api gateway" "request" will be "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "invocation" will be "FAILED" and the "api gateway" "request" will be "FAILED"')
def invocation_failed_request_failed():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
