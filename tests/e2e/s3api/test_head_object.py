import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestHeadObject:
    def test_head_object(self, e2e_port, tmp_path, lws_invoke):
        # Arrange
        bucket_name = "e2e-head-obj"
        key = "h.txt"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])
        body_file = tmp_path / "h.txt"
        body_file.write_text("data")
        lws_invoke(
            [
                "s3api",
                "put-object",
                "--bucket",
                bucket_name,
                "--key",
                key,
                "--body",
                str(body_file),
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "s3api",
                "head-object",
                "--bucket",
                bucket_name,
                "--key",
                key,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert "ContentLength" in json.loads(result.output)
