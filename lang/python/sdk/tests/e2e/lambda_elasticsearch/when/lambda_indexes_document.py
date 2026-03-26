"""When: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function indexes a document into the "AVAILABLE" domain and succeeds')
def lambda_indexes_document(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
