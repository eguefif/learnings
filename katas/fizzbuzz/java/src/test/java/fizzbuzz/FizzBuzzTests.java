import static org.junit.jupiter.api.Assertions.assertEquals;

import fizzbuzz.FizzBuzz;
import org.junit.jupiter.api.Test;

class FizzBuzzTests {
  private final FizzBuzz fb = new FizzBuzz();

  @Test
  void testFizzBuzz1() {
    assertEquals("1", fb.fizzBuzz(1));
  }

  @Test
  void testFizzBuzz3() {
    assertEquals("Fizz", fb.fizzBuzz(3));
  }

  @Test
  void testFizzBuzz5() {
    assertEquals("Buzz", fb.fizzBuzz(5));
  }

  @Test
  void testFizzBuzz15() {
    assertEquals("FizzBuzz", fb.fizzBuzz(15));
  }
}
