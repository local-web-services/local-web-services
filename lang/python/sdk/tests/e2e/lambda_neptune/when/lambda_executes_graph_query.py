"""When: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds')
def lambda_executes_graph_query(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
