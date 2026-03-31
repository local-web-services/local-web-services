"""Then: the "documentdb" "cluster" has a new primary documentdb instance"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "documentdb" "cluster" has a new primary documentdb instance')
def cluster_has_new_primary_then():
    pytest.skip("Cannot observe internal cluster primary instance change in lws")
