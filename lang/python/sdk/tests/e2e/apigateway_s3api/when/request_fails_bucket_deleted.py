"""When: a request fails because the "s3" "bucket" has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a request fails because the "s3" "bucket" has been deleted')
def request_fails_bucket_deleted(world):
    pytest.skip("Cannot simulate S3 bucket deletion failure via API Gateway in lws")
