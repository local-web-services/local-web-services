package io.localwebservices.lws.hcl;

import io.localwebservices.lws.SessionSpec;
import io.localwebservices.lws.StateMachineSpec;
import io.localwebservices.lws.TableSpec;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

/** Discovers AWS resources from Terraform HCL ({@code .tf}) files. */
public class HclDiscovery {

  private static final Pattern RESOURCE_HEADER =
      Pattern.compile("^\\s*resource\\s+\"(\\w+)\"\\s+\"\\w+\"\\s*\\{\\s*$");
  private static final Pattern ATTR_STR = Pattern.compile("^\\s*(\\w+)\\s*=\\s*\"([^\"]*)\"\\s*$");
  private static final Pattern ATTR_HEREDOC = Pattern.compile("^\\s*(\\w+)\\s*=\\s*<<(\\w+)\\s*$");

  /**
   * Scans all {@code .tf} files under {@code projectDir} and returns a {@link SessionSpec}
   * describing the discovered resources.
   */
  public static SessionSpec discover(String projectDir) throws IOException {
    List<TableSpec> tables = new ArrayList<>();
    List<String> queues = new ArrayList<>();
    List<String> buckets = new ArrayList<>();
    List<String> topics = new ArrayList<>();
    List<StateMachineSpec> stateMachines = new ArrayList<>();
    List<String> parameters = new ArrayList<>();
    List<String> secrets = new ArrayList<>();

    Path root = Path.of(projectDir);
    if (!Files.isDirectory(root)) {
      return SessionSpec.empty();
    }
    try (Stream<Path> files = Files.walk(root)) {
      files
          .filter(p -> p.toString().endsWith(".tf"))
          .forEach(
              file -> {
                try {
                  parseFile(
                      file, tables, queues, buckets, topics, stateMachines, parameters, secrets);
                } catch (IOException e) {
                  throw new UncheckedIOException(e);
                }
              });
    }
    return new SessionSpec()
        .tables(tables)
        .queues(queues)
        .buckets(buckets)
        .topics(topics)
        .stateMachines(stateMachines)
        .parameters(parameters)
        .secrets(secrets);
  }

  private static void parseFile(
      Path file,
      List<TableSpec> tables,
      List<String> queues,
      List<String> buckets,
      List<String> topics,
      List<StateMachineSpec> stateMachines,
      List<String> parameters,
      List<String> secrets)
      throws IOException {
    List<String> lines = Files.readAllLines(file);
    int i = 0;
    while (i < lines.size()) {
      Matcher m = RESOURCE_HEADER.matcher(lines.get(i));
      if (m.matches()) {
        String resourceType = m.group(1);
        int[] idx = {i + 1};
        switch (resourceType) {
          case "aws_sfn_state_machine" -> collectStateMachine(lines, idx, stateMachines);
          case "aws_dynamodb_table" -> collectDynamoTable(lines, idx, tables);
          case "aws_sqs_queue" -> {
            String name = collectSimpleAttr(lines, idx, "name");
            if (name != null) queues.add(name);
          }
          case "aws_s3_bucket" -> {
            String name = collectS3Bucket(lines, idx);
            if (name != null) buckets.add(name);
          }
          case "aws_sns_topic" -> {
            String name = collectSimpleAttr(lines, idx, "name");
            if (name != null) topics.add(name);
          }
          case "aws_ssm_parameter" -> {
            String name = collectSimpleAttr(lines, idx, "name");
            if (name != null) parameters.add(name);
          }
          case "aws_secretsmanager_secret" -> {
            String name = collectSimpleAttr(lines, idx, "name");
            if (name != null) secrets.add(name);
          }
          default -> skipBlock(lines, idx);
        }
        i = idx[0];
      } else {
        i++;
      }
    }
  }

  private static void collectStateMachine(
      List<String> lines, int[] idx, List<StateMachineSpec> result) {
    String name = null;
    String definition = null;
    String roleArn = null;
    int depth = 1;
    while (idx[0] < lines.size() && depth > 0) {
      String line = lines.get(idx[0]);
      if (depth == 1) {
        Matcher heredoc = ATTR_HEREDOC.matcher(line);
        if (heredoc.matches()) {
          String key = heredoc.group(1);
          String marker = heredoc.group(2);
          idx[0]++;
          List<String> body = new ArrayList<>();
          while (idx[0] < lines.size() && !lines.get(idx[0]).stripTrailing().equals(marker)) {
            body.add(lines.get(idx[0]));
            idx[0]++;
          }
          if ("definition".equals(key)) {
            definition = String.join("\n", body);
          }
          idx[0]++;
          continue;
        }
        Matcher attr = ATTR_STR.matcher(line);
        if (attr.matches()) {
          switch (attr.group(1)) {
            case "name" -> name = attr.group(2);
            case "role_arn" -> roleArn = attr.group(2);
            case "definition" -> definition = "\"" + attr.group(2) + "\"";
            default -> {}
          }
        }
      }
      depth += countChar(line, '{') - countChar(line, '}');
      idx[0]++;
    }
    if (name != null && definition != null) {
      StateMachineSpec sm = new StateMachineSpec(name, definition);
      if (roleArn != null) sm.roleArn(roleArn);
      result.add(sm);
    }
  }

  private static void collectDynamoTable(List<String> lines, int[] idx, List<TableSpec> result) {
    String name = null;
    String hashKey = null;
    String rangeKey = null;
    int depth = 1;
    while (idx[0] < lines.size() && depth > 0) {
      String line = lines.get(idx[0]);
      if (depth == 1) {
        Matcher attr = ATTR_STR.matcher(line);
        if (attr.matches()) {
          switch (attr.group(1)) {
            case "name" -> name = attr.group(2);
            case "hash_key" -> hashKey = attr.group(2);
            case "range_key" -> rangeKey = attr.group(2);
            default -> {}
          }
        }
      }
      depth += countChar(line, '{') - countChar(line, '}');
      idx[0]++;
    }
    if (name != null && hashKey != null) {
      TableSpec t = new TableSpec(name, hashKey);
      if (rangeKey != null) t.sortKey(rangeKey);
      result.add(t);
    }
  }

  private static String collectSimpleAttr(List<String> lines, int[] idx, String attrName) {
    String value = null;
    int depth = 1;
    while (idx[0] < lines.size() && depth > 0) {
      String line = lines.get(idx[0]);
      if (depth == 1) {
        Matcher attr = ATTR_STR.matcher(line);
        if (attr.matches() && attrName.equals(attr.group(1))) {
          value = attr.group(2);
        }
      }
      depth += countChar(line, '{') - countChar(line, '}');
      idx[0]++;
    }
    return value;
  }

  private static String collectS3Bucket(List<String> lines, int[] idx) {
    String bucket = null;
    String name = null;
    int depth = 1;
    while (idx[0] < lines.size() && depth > 0) {
      String line = lines.get(idx[0]);
      if (depth == 1) {
        Matcher attr = ATTR_STR.matcher(line);
        if (attr.matches()) {
          switch (attr.group(1)) {
            case "bucket" -> bucket = attr.group(2);
            case "name" -> name = attr.group(2);
            default -> {}
          }
        }
      }
      depth += countChar(line, '{') - countChar(line, '}');
      idx[0]++;
    }
    return bucket != null ? bucket : name;
  }

  private static void skipBlock(List<String> lines, int[] idx) {
    int depth = 1;
    while (idx[0] < lines.size() && depth > 0) {
      depth += countChar(lines.get(idx[0]), '{') - countChar(lines.get(idx[0]), '}');
      idx[0]++;
    }
  }

  private static int countChar(String s, char c) {
    int count = 0;
    for (char ch : s.toCharArray()) {
      if (ch == c) count++;
    }
    return count;
  }
}
