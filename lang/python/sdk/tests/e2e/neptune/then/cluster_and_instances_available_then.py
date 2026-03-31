"""Then: the "neptune" "cluster" and its instances are "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "neptune" "cluster" and its instances are "AVAILABLE"')
def cluster_and_instances_available_then():
    pytest.skip("Cannot observe internal cluster start completion in lws")
