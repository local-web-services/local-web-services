"""Given: traffic has been swapped to the new cluster during a blue-green deployment"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("traffic has been swapped to the new cluster during a blue-green deployment")
def opensearch_traffic_swapped_blue_green_seq():
    pytest.skip("Cannot trigger internal blue-green traffic swap in lws")
