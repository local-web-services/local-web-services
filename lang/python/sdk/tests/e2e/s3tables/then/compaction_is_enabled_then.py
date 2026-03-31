"""Then: compaction will be enabled for the "s3 tables" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('compaction will be enabled for the "s3 tables" "table"')
def compaction_is_enabled_then():
    pytest.skip("Cannot observe internal table compaction state in lws")
