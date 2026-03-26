"""When: a table bucket finishes being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a table bucket finishes being deleted")
def table_bucket_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal table bucket deletion completion in lws")
