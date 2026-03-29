"""When: the Lambda function writes a record to an "ACTIVE" table and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function writes a record to an "ACTIVE" table and succeeds')
def lambda_s3tables_function_writes_record_succeeds(world):
    pytest.skip("Cannot trigger internal Lambda->S3Tables write in lws")
