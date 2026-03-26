"""Then: the invocation is "SUCCESS" and the request is "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "SUCCESS" and the request is "SUCCESS"')
def invocation_success_request_success():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
