"""
Given: the Lambda invocation has completed successfully and the API has returned a successful
response
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "the Lambda invocation has completed successfully and the API has returned a successful response"  # noqa: E501
)
@given(
    'the Lambda invocation has completed successfully and the "API" has returned a successful response'  # noqa: E501
)
def apigw_lambda_invocation_completed_success():
    pytest.skip("Cannot represent a completed Lambda invocation as sequence setup in lws")
