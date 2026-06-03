package fizzbuzz;

public class FizzBuzz {
  public String fizzBuzz(int i) {
    if (i % 3 == 0 && i % 5 == 0) {
      return "FizzBuzz";
    } else if (i % 3 == 0) {
      return "Fizz";
    } else if (i % 5 == 0) {
      return "Buzz";
    } else {
      return Integer.toString(i);
    }
  }
}
