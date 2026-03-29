"""Then: the request is "FAILED" and no item is written"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the request is "FAILED" and no item is written')
def request_failed_no_item():
    pytest.skip("Cannot simulate DynamoDB write failure via API Gateway in lws")
