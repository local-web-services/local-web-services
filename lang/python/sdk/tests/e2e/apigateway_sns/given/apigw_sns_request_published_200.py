"""
Given: a request has been received, the "API" has published to the "SNS" topic, and returned 200
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200'
)
def apigw_sns_request_published_200():
    pytest.skip("Cannot represent a completed API-to-SNS publish as sequence setup in lws")
