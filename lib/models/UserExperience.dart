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
}