class UserExperience
{
  final int id;
  final String username;
  final String password;
  String goal;
  final String experienceName;

  UserExperience(this.id, this.username, this.password, this.goal,
                 this.experienceName);



  @override
  String toString()
  {
    return 'UserExperience{id: $id, username: $username, '
                          'password: $password, goal: $goal, '
                          'experienceName: $experienceName}';
  }

  @override
  bool operator ==(Object other)
  =>
      identical(this, other) ||
          other is UserExperience &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              username == other.username &&
              password == other.password &&
              goal == other.goal &&
              experienceName == other.experienceName;

  @override
  int get hashCode
  =>
      id.hashCode ^
      username.hashCode ^
      password.hashCode ^
      goal.hashCode ^
      experienceName.hashCode;

}