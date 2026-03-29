"""Then: the invocation is "FAILED" and the request is "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "FAILED" and the request is "FAILED"')
def invocation_failed_request_failed():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
