"""Given: a table bucket has finished being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a table bucket has finished being deleted")
def s3tables_a_table_bucket_has_finished_being_deleted():
    pytest.skip("Cannot trigger internal table bucket deletion completion in lws")
