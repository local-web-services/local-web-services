"""When: a "rds" "instance" restore from "rds" "snapshot" completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "rds" "instance" restore from "rds" "snapshot" completes')
def instance_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal RDS instance restore completion in lws")
