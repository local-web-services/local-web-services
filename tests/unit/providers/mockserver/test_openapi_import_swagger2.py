"""Unit tests for Swagger 2.0 spec import."""

from __future__ import annotations

from lws.providers.mockserver.openapi_import import import_openapi_spec


class TestImportSwagger2:
    def test_swagger2_import(self, tmp_path):
        # Arrange
        spec = tmp_path / "spec.yaml"
        spec.write_text(
            "swagger: '2.0'\n"
            "info:\n"
            "  title: Test\n"
            "  version: '1.0'\n"
            "paths:\n"
            "  /v1/items:\n"
            "    get:\n"
            "      responses:\n"
            "        '200':\n"
            "          description: OK\n"
            "          schema:\n"
            "            type: object\n"
            "            properties:\n"
            "              items:\n"
            "                type: array\n"
            "                items:\n"
            "                  type: string\n"
        )
        output_dir = tmp_path / "mock-api"
        output_dir.mkdir()

        # Act
        generated = import_openapi_spec(spec, output_dir)

        # Assert
        assert len(generated) > 0
