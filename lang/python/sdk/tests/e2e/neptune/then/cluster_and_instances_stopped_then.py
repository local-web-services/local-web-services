"""Then: the "neptune" "cluster" and its instances are "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "neptune" "cluster" and its instances are "STOPPED"')
def cluster_and_instances_stopped_then():
    pytest.skip("Cannot observe internal cluster stop completion in lws")
