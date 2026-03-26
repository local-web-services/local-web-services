"""Given: compaction has been started on a table"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("compaction has been started on a table")
def s3tables_compaction_has_been_started():
    pytest.skip("start_table_bucket_maintenance API not available in this botocore version")
