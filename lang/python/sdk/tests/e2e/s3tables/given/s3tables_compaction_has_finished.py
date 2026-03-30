"""Given: compaction has finished on a table"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("compaction has finished on a table")
def s3tables_compaction_has_finished():
    pytest.skip("Cannot trigger internal table compaction completion in lws")
