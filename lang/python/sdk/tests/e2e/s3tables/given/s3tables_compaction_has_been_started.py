"""Given: compaction is started on a "s3 tables" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('compaction is started on a "s3 tables" "table"')
def s3tables_compaction_has_been_started():
    pytest.skip("start_table_bucket_maintenance API not available in this botocore version")
