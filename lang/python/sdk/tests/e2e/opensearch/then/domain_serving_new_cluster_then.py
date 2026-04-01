"""Then: the "opensearch" "domain" will now be serving requests from the new "opensearch" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "opensearch" "domain" will now be serving requests from the new "opensearch" "cluster"')
def domain_serving_new_cluster_then():
    pytest.skip("Cannot observe internal blue-green traffic swap in lws")
