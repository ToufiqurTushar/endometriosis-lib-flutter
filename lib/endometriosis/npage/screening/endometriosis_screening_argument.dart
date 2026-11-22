class EndometriosisScreeningArgument {
  EndometriosisScreeningArgument({
      this.userId,
      this.birthDate,
      this.isCoreUserAppOrI4WeMemberApp = false,
      this.isCoreAgentAppOrI4WeAgentApp = false
  });

  int? userId;
  int? birthDate;
  bool isCoreUserAppOrI4WeMemberApp;
  bool isCoreAgentAppOrI4WeAgentApp;

}