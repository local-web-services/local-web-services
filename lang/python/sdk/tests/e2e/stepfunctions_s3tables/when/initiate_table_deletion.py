"""When: a table deletion is initiated"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a table deletion is initiated")
def initiate_table_deletion(lws_session, world):
    pytest.skip("Cannot trigger internal S3 Tables table deletion in lws")
