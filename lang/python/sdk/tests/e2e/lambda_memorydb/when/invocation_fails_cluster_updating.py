"""When: the Lambda function fails to write because the cluster is updating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails to write because the cluster is updating")
def invocation_fails_cluster_updating(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
