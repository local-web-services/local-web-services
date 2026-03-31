"""Given: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" writes a record to an "ACTIVE" table and succeeds')
def lambda_s3tables_written_record_succeeded_seq():
    pytest.skip("Cannot trigger Lambda S3Tables write in lws")
