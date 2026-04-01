"""Given: the "s3 tables" "table" has more than one s3 tables snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "table" has more than one s3 tables snapshot')
def table_has_more_than_one_snapshot():
    pytest.skip("Cannot configure multiple table snapshots in this context")
