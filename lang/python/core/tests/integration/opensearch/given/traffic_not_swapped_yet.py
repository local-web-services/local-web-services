"""Given: the "opensearch" "domain" blue-green traffic had not been swapped yet"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "domain" blue-green traffic had not been swapped yet')
def traffic_not_swapped_yet(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")
