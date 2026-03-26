"""Given: the Lambda function has failed to write because the cluster is updating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed to write because the cluster is updating")
def lambda_failed_write_cluster_updating_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")
