package com.exercice.app;

/** Hello world! */
public class App {
  public static void main(String[] args) {
    TaskManager manager = new TaskManager();
    manager.addTask("Buy groceries");
    manager.addTask("Do workout");
    manager.printSummary();
  }
}

class TaskManager {
  static class TasksStat {
    public static void printSummary() {
      System.out.println("Summary");
      System.out.println("  done: " + doneCount);
      System.out.println("  to do: " + todoCount);
    }
  }

  class Task {
    String title;
    boolean done;

    Task(String newTaskTitle) {
      title = newTaskTitle;
      done = false;
    }

    public void complete() {
      done = true;
      doneCount++;
      todoCount--;
    }
  }

  public Task[] tasks;
  int idx;
  static int doneCount = 0;
  static int todoCount = 0;

  TaskManager() {
    tasks = new Task[200];
    idx = 0;
  }

  public void addTask(String newTaskTitle) {
    Task newTask = new Task(newTaskTitle);
    tasks[idx] = newTask;
    todoCount++;
    idx++;
  }

  public void printSummary() {
    class ReportLine {
      Task task;
      int lineNumber;

      ReportLine(Task givenTask, int givenLineNumber) {
        task = givenTask;
        lineNumber = givenLineNumber;
      }

      public void print() {
        char done = 'x';
        if (task.done == false) {
          done = ' ';
        }
        System.out.printf("%d. [%c] %s\n", lineNumber, done, task.title);
      }
    }

    TasksStat stats = new TasksStat();
    stats.printSummary();
    System.out.println("Tasks Summary");
    for (int i = 0; i < idx; i++) {
      ReportLine report = new ReportLine(tasks[i], i + 1);
      report.print();
    }
  }
}
