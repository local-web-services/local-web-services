"""Given: a database instance modification has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance modification has completed")
def neptune_database_instance_modification_completed_seq():
    pytest.skip("Cannot trigger internal Neptune instance modification completion in lws")
