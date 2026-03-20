"""Unit tests for fake server template rendering — nested structures."""

from __future__ import annotations

from lws.providers.fakeserver.template import render_template


class TestRenderNested:
    def test_dict_rendering(self):
        # Arrange
        expected_name = "test"
        template = {"id": "{{path.id}}", "name": expected_name}
        expected_id = "abc"

        # Act
        actual = render_template(template, path_params={"id": expected_id})

        # Assert
        actual_id = actual["id"]
        actual_name = actual["name"]
        assert actual_id == expected_id, f"Expected {expected_id!r} but got {actual_id!r}"
        assert actual_name == expected_name, f"Expected {expected_name!r} but got {actual_name!r}"

    def test_list_rendering(self):
        # Arrange
        expected_second = "static"
        template = ["{{path.id}}", expected_second]
        expected_first = "xyz"

        # Act
        actual = render_template(template, path_params={"id": expected_first})

        # Assert
        actual_first = actual[0]
        actual_second = actual[1]
        assert (
            actual_first == expected_first
        ), f"Expected {expected_first!r} but got {actual_first!r}"
        assert (
            actual_second == expected_second
        ), f"Expected {expected_second!r} but got {actual_second!r}"

    def test_non_string_passthrough(self):
        # Arrange
        template = 42

        # Act
        actual = render_template(template)

        # Assert
        assert actual == 42, f"Expected {42!r} but got {actual!r}"
