from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetObject:
    def test_get_object(self, e2e_port, tmp_path, lws_invoke):
        # Arrange
        bucket_name = "e2e-get-obj"
        key = "doc.txt"
        expected_content = "hello world"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])
        body_file = tmp_path / "input.txt"
        body_file.write_text(expected_content)
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
        outfile = tmp_path / "output.txt"
        result = runner.invoke(
            app,
            [
                "s3api",
                "get-object",
                "--bucket",
                bucket_name,
                "--key",
                key,
                str(outfile),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_content = outfile.read_text()
        assert actual_content == expected_content
