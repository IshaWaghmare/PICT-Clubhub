class UserLoginController {
  static String id = "";
  static String username = "";
  static String email = "";
  static String role = "user";

  static void setId(String newId) {
    id = newId;
  }

  static String getId() {
    return id;
  }

  static void setUsername(String newUsername) {
    username = newUsername;
  }

  static String getUsername() {
    return username;
  }

  static void setEmail(String newEmail) {
    email = newEmail;
  }

  static String getEmail() {
    return email;
  }

  static void setRole(String newRole) {
    role = newRole;
  }

  static String getRole() {
    return role;
  }

  static void logout() {
    id = "";
    username = "";
    email = "";
    role = "user";
  }
}
