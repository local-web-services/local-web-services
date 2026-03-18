package io.localwebservices.lws;

/** Describes a Step Functions state machine to create in the local session. */
public class StateMachineSpec {

  private final String name;
  private final String definition;
  private String roleArn;

  public StateMachineSpec(String name, String definition) {
    this.name = name;
    this.definition = definition;
  }

  public StateMachineSpec roleArn(String roleArn) {
    this.roleArn = roleArn;
    return this;
  }

  public String getName() {
    return name;
  }

  public String getDefinition() {
    return definition;
  }

  public String getRoleArn() {
    return roleArn;
  }
}
