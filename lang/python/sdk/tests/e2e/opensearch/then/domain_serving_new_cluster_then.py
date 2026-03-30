"""Then: the domain is now serving requests from the new cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the domain is now serving requests from the new cluster")
def domain_serving_new_cluster_then():
    pytest.skip("Cannot observe internal blue-green traffic swap in lws")
