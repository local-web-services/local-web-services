"""Then: the request is "FAILED" and no message is published"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the request is "FAILED" and no message is published')
def request_failed_no_message():
    pytest.skip("Cannot simulate SNS publish failure via API Gateway in lws")
