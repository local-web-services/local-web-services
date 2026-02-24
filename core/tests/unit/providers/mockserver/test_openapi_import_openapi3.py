"""Unit tests for OpenAPI 3.x spec import."""

from __future__ import annotations

from lws.providers.mockserver.openapi_import import import_openapi_spec


class TestImportOpenApi3:
    def test_basic_spec_import(self, tmp_path):
        # Arrange
        spec = tmp_path / "spec.yaml"
        spec.write_text(
            "openapi: '3.0.0'\n"
            "info:\n"
            "  title: Test API\n"
            "  version: '1.0'\n"
            "paths:\n"
            "  /v1/users:\n"
            "    get:\n"
            "      summary: List users\n"
            "      responses:\n"
            "        '200':\n"
            "          description: OK\n"
            "          content:\n"
            "            application/json:\n"
            "              example:\n"
            "                users: []\n"
        )
        output_dir = tmp_path / "mock-api"
        output_dir.mkdir()

        # Act
        generated = import_openapi_spec(spec, output_dir)

        # Assert
        assert len(generated) > 0
        assert (output_dir / "spec.yaml").exists()

    def test_multiple_paths(self, tmp_path):
        # Arrange
        spec = tmp_path / "spec.yaml"
        spec.write_text(
            "openapi: '3.0.0'\n"
            "info:\n"
            "  title: Test\n"
            "  version: '1.0'\n"
            "paths:\n"
            "  /v1/users:\n"
            "    get:\n"
            "      responses:\n"
            "        '200':\n"
            "          description: OK\n"
            "  /v1/orders:\n"
            "    post:\n"
            "      responses:\n"
            "        '201':\n"
            "          description: Created\n"
        )
        output_dir = tmp_path / "mock-api"
        output_dir.mkdir()

        # Act
        generated = import_openapi_spec(spec, output_dir)

        # Assert
        expected_count = 2
        assert len(generated) == expected_count

    def test_no_overwrite_skips_existing(self, tmp_path):
        # Arrange
        spec = tmp_path / "spec.yaml"
        spec.write_text(
            "openapi: '3.0.0'\n"
            "info:\n"
            "  title: Test\n"
            "  version: '1.0'\n"
            "paths:\n"
            "  /v1/users:\n"
            "    get:\n"
            "      responses:\n"
            "        '200':\n"
            "          description: OK\n"
        )
        output_dir = tmp_path / "mock-api"
        output_dir.mkdir()
        routes_dir = output_dir / "routes"
        routes_dir.mkdir()
        existing = routes_dir / "v1_users_get.yaml"
        existing.write_text("existing content")

        # Act
        generated = import_openapi_spec(spec, output_dir, overwrite=False)

        # Assert
        assert len(generated) == 0
        expected_content = "existing content"
        actual_content = existing.read_text()
        assert actual_content == expected_content

    def test_overwrite_replaces_existing(self, tmp_path):
        # Arrange
        spec = tmp_path / "spec.yaml"
        spec.write_text(
            "openapi: '3.0.0'\n"
            "info:\n"
            "  title: Test\n"
            "  version: '1.0'\n"
            "paths:\n"
            "  /v1/users:\n"
            "    get:\n"
            "      responses:\n"
            "        '200':\n"
            "          description: OK\n"
        )
        output_dir = tmp_path / "mock-api"
        output_dir.mkdir()
        routes_dir = output_dir / "routes"
        routes_dir.mkdir()
        existing = routes_dir / "v1_users_get.yaml"
        existing.write_text("old content")

        # Act
        generated = import_openapi_spec(spec, output_dir, overwrite=True)

        # Assert
        assert len(generated) == 1
