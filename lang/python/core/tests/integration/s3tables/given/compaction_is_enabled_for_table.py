"""Given: compaction will be enabled for the "s3 tables" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('compaction was "ENABLED" for the "s3 tables" "table"')
@given('compaction will be enabled for the "s3 tables" "table"')
def compaction_is_enabled_for_table():
    pytest.skip("Compaction configuration is not available in integration context")
