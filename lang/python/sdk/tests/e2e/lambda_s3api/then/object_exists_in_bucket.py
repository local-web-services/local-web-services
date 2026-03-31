"""Then: the object will exist in the "s3" "bucket" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the object will exist in the "s3" "bucket"')
def object_exists_in_bucket(world):
    pytest.skip("Cannot observe Lambda object write result in lws")
