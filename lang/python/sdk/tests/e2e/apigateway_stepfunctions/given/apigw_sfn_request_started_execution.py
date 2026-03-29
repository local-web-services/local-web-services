"""
Given: the "API" has received an "HTTP" request and synchronously started a Step Functions
execution
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the "API" has received an "HTTP" request and synchronously started a Step Functions execution'
)  # noqa: E501
def apigw_sfn_request_started_execution():
    pytest.skip(
        "Cannot represent a completed API-to-StepFunctions execution as sequence setup in lws"
    )
