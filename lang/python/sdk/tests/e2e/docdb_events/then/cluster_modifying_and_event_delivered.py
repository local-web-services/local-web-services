"""Then: the cluster is "MODIFYING" and the "MODIFIED" event is "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "MODIFYING" and the "MODIFIED" event is "DELIVERED"')
def cluster_modifying_and_event_delivered():
    pytest.skip("Cannot trigger internal DocumentDB cluster modification event delivery in lws")
