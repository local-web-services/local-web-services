"""Given: the "lambda" "function" indexes a document into the OpenSearch index during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" indexes a document into the OpenSearch index during invocation')
def lambda_indexed_document_seq():
    pytest.skip("Cannot trigger Lambda OpenSearch index in lws")
