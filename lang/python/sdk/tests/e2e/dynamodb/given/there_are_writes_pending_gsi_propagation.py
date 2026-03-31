"""Given: there were writes pending propagation to the "GSI" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('there were writes pending propagation to the "GSI"')
def there_are_writes_pending_gsi_propagation():
    pytest.skip("Cannot configure GSI propagation in this abstract context")
