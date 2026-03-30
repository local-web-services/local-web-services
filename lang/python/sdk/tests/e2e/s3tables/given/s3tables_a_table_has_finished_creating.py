"""Given: a table has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a table has finished creating")
def s3tables_a_table_has_finished_creating():
    pytest.skip("Cannot trigger internal table creation completion in lws")
