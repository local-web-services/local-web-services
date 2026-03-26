"""Given: the table bucket is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table bucket is not "ACTIVE"')
def lambda_s3tables_table_bucket_is_not_active_given():
    pytest.skip("Cannot put an S3 table bucket into a non-ACTIVE state in lws")
