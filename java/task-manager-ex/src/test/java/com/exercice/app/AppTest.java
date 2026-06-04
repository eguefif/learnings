package com.exercice.app;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

/** Unit test for simple App. */
public class AppTest {
  TaskManager manager = new TaskManager();

  /** Rigorous Test :-) */
  @Test
  public void shouldCreateOneTask() {
    manager.addTask("Buy groceries");
    assertEquals(manager.idx, 1);
  }
}
