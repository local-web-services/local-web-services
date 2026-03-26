"""
Given: a request has been received but the "SNS" publish has failed because the topic has been
deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a request has been received but the "SNS" publish has failed because the topic has been deleted'  # noqa: E501
)
def apigw_sns_request_failed_topic_deleted():
    pytest.skip("Cannot represent a failed SNS publish as sequence setup in lws")
