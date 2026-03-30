"""Given: the domain is "PROCESSING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is "PROCESSING"')
def domain_is_processing_given():
    pytest.skip("Cannot trigger internal domain PROCESSING state in lws")
