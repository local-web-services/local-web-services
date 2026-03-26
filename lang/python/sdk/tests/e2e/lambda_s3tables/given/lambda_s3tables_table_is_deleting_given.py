"""Given: the table is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table is "DELETING"')
def lambda_s3tables_table_is_deleting_given():
    pytest.skip("Cannot put an S3 Tables table into DELETING state in lws")
