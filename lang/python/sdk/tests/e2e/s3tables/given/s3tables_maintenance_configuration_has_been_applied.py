"""Given: maintenance configuration has been applied to a table"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("maintenance configuration has been applied to a table")
def s3tables_maintenance_configuration_has_been_applied():
    pytest.skip("put_table_maintenance_configuration is not supported in lws")
