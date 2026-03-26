"""When: the Lambda function indexes a document into the OpenSearch index during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function indexes a document into the OpenSearch index during invocation")
def lambda_indexes_document(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
