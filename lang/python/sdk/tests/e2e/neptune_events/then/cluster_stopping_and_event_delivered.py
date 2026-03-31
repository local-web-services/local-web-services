"""Then: the "neptune" "cluster" will be "STOPPING" and the "STOPPED" event will be "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "neptune" "cluster" will be "STOPPING" and the "STOPPED" event will be "DELIVERED"')
def cluster_stopping_and_event_delivered():
    pytest.skip("Cannot trigger internal Neptune cluster stop event delivery in lws")
