"""Then: the "s3 tables" "table" schema version will be incremented"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "s3 tables" "table" schema version will be incremented')
def schema_version_incremented_then():
    pytest.skip("Cannot observe internal schema version changes without Iceberg client in lws")
