"""Then: the cluster is "STOPPING" and the "STOPPED" event is "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "STOPPING" and the "STOPPED" event is "DELIVERED"')
def cluster_stopping_and_event_delivered():
    pytest.skip("Cannot trigger internal Neptune cluster stop event delivery in lws")
