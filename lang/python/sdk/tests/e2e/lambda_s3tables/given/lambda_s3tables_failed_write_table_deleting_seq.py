"""Given: the Lambda function has failed to write because the table is being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed to write because the table is being deleted")
def lambda_s3tables_failed_write_table_deleting_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")
