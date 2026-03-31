"""Given: a "neptune" "instance" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "instance" deletion completes')
def neptune_database_instance_deletion_completed_seq():
    pytest.skip("Cannot trigger internal Neptune instance deletion completion in lws")
