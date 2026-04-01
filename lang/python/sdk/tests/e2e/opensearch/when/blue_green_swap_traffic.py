"""When: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment')
def blue_green_swap_traffic(lws_session, world):
    pytest.skip("Cannot trigger internal blue-green traffic swap in lws")
