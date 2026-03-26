"""
Given: the Lambda function has failed to write because the domain is processing a config update
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed to write because the domain is processing a config update")
def lambda_elasticsearch_seq_invocation_failed():
    pytest.skip("Cannot trigger Lambda invocation in lws")
