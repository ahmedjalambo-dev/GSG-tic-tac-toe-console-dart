bool isValidInput(String? input) {
  if (input == null || int.tryParse(input) == null) {
    print("❌ Invalid input. Please enter a number between 1 and 9.");
    return false;
  }

  int move = int.parse(input);
  if (move < 1 || move > 9) {
    print("❌ Move out of range. Choose between 1 and 9.");
    return false;
  }

  return true;
}
