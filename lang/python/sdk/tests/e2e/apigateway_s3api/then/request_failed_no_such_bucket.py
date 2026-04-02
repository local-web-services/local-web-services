"""Then: the "api gateway" "request" will be "FAILED" with a NoSuchBucket error"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "api gateway" "request" will be "FAILED" with a NoSuchBucket error')
def request_failed_no_such_bucket():
    pytest.skip("Cannot simulate S3 NoSuchBucket failure via API Gateway in lws")
