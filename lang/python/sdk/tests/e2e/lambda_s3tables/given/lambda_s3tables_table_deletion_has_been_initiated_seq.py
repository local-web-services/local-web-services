"""Given: a table deletion has been initiated"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a table deletion has been initiated")
def lambda_s3tables_table_deletion_has_been_initiated_seq():
    pytest.skip("Cannot trigger S3 Tables table deletion in lws")
