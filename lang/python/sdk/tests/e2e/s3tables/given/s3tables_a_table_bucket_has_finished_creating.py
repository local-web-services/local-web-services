"""Given: a table bucket has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a table bucket has finished creating")
def s3tables_a_table_bucket_has_finished_creating():
    pytest.skip("Cannot trigger internal table bucket creation completion in lws")
