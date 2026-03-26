"""Given: the Lambda function has failed to connect because the Neptune cluster is stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed to connect because the Neptune cluster is stopped")
def lambda_failed_connect_cluster_stopped_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")
