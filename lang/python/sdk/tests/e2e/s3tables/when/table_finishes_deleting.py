"""When: a "s3 tables" "table" finishes being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "s3 tables" "table" finishes being deleted')
def table_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal table deletion completion in lws")
