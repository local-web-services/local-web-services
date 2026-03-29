"""When: the "API" receives an "HTTP" request and synchronously invokes the Lambda function"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "API" receives an "HTTP" request and synchronously invokes the Lambda function')
def api_receives_request_invokes_lambda(world):
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
