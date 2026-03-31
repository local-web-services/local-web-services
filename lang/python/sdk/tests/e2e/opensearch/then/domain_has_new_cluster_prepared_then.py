"""Then: the "opensearch" "domain" will have a new cluster prepared but traffic will not yet be swapped"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "opensearch" "domain" will have a new cluster prepared but traffic will not yet be swapped'
)
def domain_has_new_cluster_prepared_then():
    pytest.skip("Cannot observe internal blue-green deployment state in lws")
