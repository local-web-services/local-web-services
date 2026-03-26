"""When: the Lambda function fails to write because the table is being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails to write because the table is being deleted")
def lambda_s3tables_function_fails_write_table_deleting(world):
    pytest.skip("Cannot trigger internal Lambda->S3Tables write failure in lws")
