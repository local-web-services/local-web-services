"""Given: the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded')
def elasticsearch_lambda_indexed_document():
    pytest.skip("Cannot trigger Lambda invocation in lws")
