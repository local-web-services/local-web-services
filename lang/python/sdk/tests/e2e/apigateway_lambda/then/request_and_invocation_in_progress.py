"""Then: the "api gateway" "request" and "lambda" "invocation" are both "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "api gateway" "request" and "lambda" "invocation" are both "IN_PROGRESS"')
def request_and_invocation_in_progress():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
