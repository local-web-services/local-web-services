"""
Given: a "GET" request has been received and the "API" has retrieved an existing object from S3
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "GET" request has been received and the "API" has retrieved an existing object from S3')
def apigw_s3api_get_request_retrieved():
    pytest.skip("Cannot represent a completed API-to-S3 read as sequence setup in lws")
