"""Given: a "s3 tables" "table" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "s3 tables" "table" finishes creating')
def s3tables_a_table_has_finished_creating():
    pytest.skip("Cannot trigger internal table creation completion in lws")
