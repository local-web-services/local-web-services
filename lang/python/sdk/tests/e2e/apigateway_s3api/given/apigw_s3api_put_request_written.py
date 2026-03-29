"""Given: a "PUT" request has been received and the "API" has written an object to the S3 bucket"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "PUT" request has been received and the "API" has written an object to the S3 bucket')
def apigw_s3api_put_request_written():
    pytest.skip("Cannot represent a completed API-to-S3 write as sequence setup in lws")
