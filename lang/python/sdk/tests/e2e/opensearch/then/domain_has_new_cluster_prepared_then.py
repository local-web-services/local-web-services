"""Then: the domain has a new cluster prepared but traffic is not yet swapped"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the domain has a new cluster prepared but traffic is not yet swapped")
def domain_has_new_cluster_prepared_then():
    pytest.skip("Cannot observe internal blue-green deployment state in lws")
