"""Then: the "api gateway" "request" will be "FAILED" and no message will be published"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "api gateway" "request" will be "FAILED" and no message will be published')
def request_failed_no_message():
    pytest.skip("Cannot simulate SNS publish failure via API Gateway in lws")
