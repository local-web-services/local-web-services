"""When: the "DB" instance finishes stopping"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "DB" instance finishes stopping')
def db_stop_complete(lws_session, world):
    pytest.skip("Cannot trigger internal RDS DB instance stop completion in lws")
