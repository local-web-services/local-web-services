"""Then: the "documentdb" "cluster" will be "MODIFYING" and the "MODIFIED" event will be "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "documentdb" "cluster" will be "MODIFYING" and the "MODIFIED" event will be "DELIVERED"')
def cluster_modifying_and_event_delivered():
    pytest.skip("Cannot trigger internal DocumentDB cluster modification event delivery in lws")
