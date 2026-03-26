"""When: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds')
def lambda_writes_document(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
