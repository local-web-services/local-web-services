"""Given: the table is already "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table is already "DELETING"')
def lambda_s3tables_table_is_already_deleting_given():
    pytest.skip("Cannot put an S3 Tables table into DELETING state in lws")
