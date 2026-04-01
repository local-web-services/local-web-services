"""Given: the "documentdb" "instance" is the primary of the "documentdb" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" is the primary of the "documentdb" "cluster"')
def instance_is_primary_of_cluster():
    pytest.skip("Cannot control primary instance assignment in lws")
