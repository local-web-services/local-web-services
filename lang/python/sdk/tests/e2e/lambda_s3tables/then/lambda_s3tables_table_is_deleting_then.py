"""Then: the table is "DELETING" and write operations will fail"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the table is "DELETING" and write operations will fail')
def lambda_s3tables_table_is_deleting_then():
    pytest.skip("Cannot observe S3 Tables table DELETING state in lws")
