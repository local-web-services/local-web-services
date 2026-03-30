"""
Given: the Step Functions execution has completed successfully and the "API" has returned a
successful response
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the Step Functions execution has completed successfully and the "API" has returned a successful response'  # noqa: E501
)
def apigw_sfn_execution_completed_success():
    pytest.skip("Cannot represent a completed Step Functions execution as sequence setup in lws")
