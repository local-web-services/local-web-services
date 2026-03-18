package io.localwebservices.lws.providers.s3;

import com.sun.net.httpserver.HttpExchange;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.*;

/** HTTP response and utility helpers for S3 handler. */
class S3HttpHelper {

  static byte[] decodeAwsChunkedIfNeeded(HttpExchange exchange, byte[] body) {
    String contentEncoding = exchange.getRequestHeaders().getFirst("Content-Encoding");
    String contentSha256 = exchange.getRequestHeaders().getFirst("x-amz-content-sha256");
    boolean isAwsChunked =
        "aws-chunked".equals(contentEncoding)
            || (contentSha256 != null && contentSha256.startsWith("STREAMING-"));
    if (!isAwsChunked) return body;

    try {
      ByteArrayOutputStream decoded = new ByteArrayOutputStream();
      int i = 0;
      String text = new String(body, StandardCharsets.ISO_8859_1);
      while (i < text.length()) {
        int lineEnd = text.indexOf("\r\n", i);
        if (lineEnd < 0) break;
        String sizeLine = text.substring(i, lineEnd);
        int semiColon = sizeLine.indexOf(';');
        String hexSize = semiColon >= 0 ? sizeLine.substring(0, semiColon) : sizeLine;
        hexSize = hexSize.trim();
        if (hexSize.isEmpty()) {
          i = lineEnd + 2;
          continue;
        }
        int chunkSize;
        try {
          chunkSize = Integer.parseInt(hexSize, 16);
        } catch (NumberFormatException e) {
          break;
        }
        if (chunkSize == 0) break;
        i = lineEnd + 2;
        byte[] chunk =
            new String(body, i, chunkSize, StandardCharsets.ISO_8859_1)
                .getBytes(StandardCharsets.ISO_8859_1);
        decoded.write(chunk);
        i += chunkSize + 2;
      }
      return decoded.toByteArray();
    } catch (IndexOutOfBoundsException | IOException e) {
      return body;
    }
  }

  static void echoChecksumHeaders(HttpExchange exchange) {
    String[] checksumHeaders = {
      "x-amz-checksum-crc32",
      "x-amz-checksum-crc32c",
      "x-amz-checksum-sha1",
      "x-amz-checksum-sha256"
    };
    for (String header : checksumHeaders) {
      String value = exchange.getRequestHeaders().getFirst(header);
      if (value != null) {
        exchange.getResponseHeaders().set(header, value);
      }
    }
  }

  static String md5Hex(byte[] data) {
    try {
      MessageDigest md = MessageDigest.getInstance("MD5");
      byte[] digest = md.digest(data);
      StringBuilder sb = new StringBuilder();
      for (byte b : digest) sb.append(String.format("%02x", b));
      return sb.toString();
    } catch (Exception e) {
      return "d41d8cd98f00b204e9800998ecf8427e";
    }
  }

  static void sendXml(HttpExchange exchange, int status, String xml) throws IOException {
    byte[] bytes = xml.getBytes(StandardCharsets.UTF_8);
    exchange.getResponseHeaders().set("Content-Type", "application/xml");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }

  static void sendEmpty(HttpExchange exchange, int status) throws IOException {
    exchange.sendResponseHeaders(status, -1);
  }

  static void sendS3Error(HttpExchange exchange, int status, String code, String message)
      throws IOException {
    String xml =
        "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Error><Code>"
            + code
            + "</Code><Message>"
            + message
            + "</Message></Error>";
    sendXml(exchange, status, xml);
  }

  static Map<String, String> parseQuery(String query) {
    Map<String, String> result = new LinkedHashMap<>();
    if (query == null || query.isEmpty()) return result;
    for (String pair : query.split("&")) {
      String[] kv = pair.split("=", 2);
      result.put(kv[0], kv.length > 1 ? kv[1] : "");
    }
    return result;
  }
}
