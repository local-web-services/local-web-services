"""Given: compaction was "ENABLED" for the "s3 tables" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('compaction was "ENABLED" for the "s3 tables" "table"')
def compaction_enabled_given():
    pytest.skip("Cannot configure table compaction in this context")
