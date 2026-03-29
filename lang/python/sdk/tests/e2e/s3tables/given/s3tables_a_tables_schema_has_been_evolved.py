"""Given: a table's schema has been evolved"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a table's schema has been evolved")
def s3tables_a_tables_schema_has_been_evolved():
    pytest.skip("Cannot evolve table schema without Iceberg client in lws")
