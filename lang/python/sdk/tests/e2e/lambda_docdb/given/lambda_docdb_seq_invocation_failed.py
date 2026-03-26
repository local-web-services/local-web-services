"""Given: the Lambda function has failed to connect because the DocumentDB cluster is stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed to connect because the DocumentDB cluster is stopped")
def lambda_docdb_seq_invocation_failed():
    pytest.skip("Cannot trigger Lambda invocation in lws")
