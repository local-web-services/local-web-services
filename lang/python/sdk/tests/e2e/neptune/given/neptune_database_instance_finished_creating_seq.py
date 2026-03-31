"""Given: a "neptune" "instance" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "instance" finishes creating')
def neptune_database_instance_finished_creating_seq():
    pytest.skip("Cannot trigger internal Neptune instance creation completion in lws")
