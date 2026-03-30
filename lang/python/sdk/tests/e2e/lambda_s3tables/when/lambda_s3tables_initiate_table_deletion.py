"""When: a table deletion is initiated"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a table deletion is initiated")
def lambda_s3tables_initiate_table_deletion(world):
    pytest.skip("Cannot trigger S3 Tables table deletion in lws")
