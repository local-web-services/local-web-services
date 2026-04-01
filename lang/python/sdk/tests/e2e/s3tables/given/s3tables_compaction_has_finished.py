"""Given: compaction finishes on a "s3 tables" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('compaction finishes on a "s3 tables" "table"')
def s3tables_compaction_has_finished():
    pytest.skip("Cannot trigger internal table compaction completion in lws")
