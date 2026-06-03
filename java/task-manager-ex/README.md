# Java Exercise: Mini Task Manager

Practice project covering all four nested class types from the [dev.java nested classes tutorial](https://dev.java/learn/classes-objects/nested-classes/).

## Goal

Build a `TaskManager` class that holds a list of tasks, lets you add them, filter them, and print reports.

---

## Part 1 — Inner class: `Task`

Inside `TaskManager`, define an inner class `Task` with:

- `String title`
- `boolean done`
- a method `complete()` that marks it done

Since `Task` only makes sense inside a `TaskManager`, nesting it is the right call. It should directly access the manager's fields if needed (e.g. a task counter).

```java
TaskManager manager = new TaskManager();
manager.addTask("Buy groceries");
manager.addTask("Write report");
```

**What to observe:** the inner class accesses `TaskManager`'s instance fields directly, without needing a reference.

---

## Part 2 — Static nested class: `Stats`

Add a `static nested class Stats` inside `TaskManager` with:

- `int total`
- `int completed`
- a method `printSummary()` that prints both counts

It is `static` because it does not need access to a specific `TaskManager` instance — it just holds data passed to it.

```java
TaskManager.Stats stats = new TaskManager.Stats(total, completed);
stats.printSummary();
```

**What to observe:** try accessing a non-static field of `TaskManager` directly from `Stats` — the compiler will refuse. You must pass a reference explicitly.

---

## Part 3 — Local class: `ReportLine`

Inside a method `printReport()`, declare a local class `ReportLine` that:

- takes a `Task` and a line number in its constructor
- has a `print()` method outputting: `1. [X] Buy groceries` or `2. [ ] Write report`

This forces you to deal with the **effectively-final** constraint: use a local variable as the line counter and make sure the local class can capture it. Do not reassign it inside the loop.

**What to observe:** if you try to increment the counter inside the loop and use it in `ReportLine`, the compiler will error with *"local variables referenced from a local class must be final or effectively final"*. Think about why before fixing it.

---

## Part 4 — Anonymous class: `TaskFilter`

Declare an interface (top-level or inside `TaskManager`):

```java
interface TaskFilter {
    boolean accept(Task t);
}
```

Write a method in `TaskManager`:

```java
List<Task> filter(TaskFilter f)
```

Then in `main`, call it twice using anonymous classes — once for completed tasks, once for tasks whose title contains a keyword:

```java
List<Task> done = manager.filter(new TaskFilter() {
    public boolean accept(Task t) {
        return t.done;
    }
});

List<Task> urgent = manager.filter(new TaskFilter() {
    public boolean accept(Task t) {
        return t.title.contains("report");
    }
});
```

**Bonus:** once it works, rewrite one filter as a lambda (`t -> t.done`). This works because `TaskFilter` is a functional interface (one abstract method).

---

## Part 5 — Shadowing (bonus)

Add a field `String name` to both `TaskManager` and `Task`. Inside `Task`, write a method that prints both values:

- `this.name` → the `Task`'s own field
- `TaskManager.this.name` → the outer class's field

Expected output:

```
Task name: Write report
Manager name: My Task Manager
```

---

## Expected final structure

```
TaskManager
├── Task                  (inner class)
├── Stats                 (static nested class)
├── TaskFilter            (interface)
├── addTask(String)
├── filter(TaskFilter)
└── printReport()
      └── ReportLine      (local class inside this method)
```

---

## Tips

- Write the class skeletons first before adding any logic.
- For Part 3, intentionally trigger the compiler error before fixing it — that's the learning moment.
- For Part 4, anonymous classes are verbose on purpose here. The lambda bonus shows where Java went next with this pattern.
- Parts can be done independently if you want to focus on one concept at a time.
