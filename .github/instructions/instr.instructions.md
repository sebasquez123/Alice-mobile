---
applyTo: '**'
---

Constricts, Rules and Guidelines for code suggestions.

### Behavioral Guidelines
Always follow and suggest using clean code, clean architecture, and best practices for the given programming language and framework. (Dart and Flutter)

When suggesting code, ensure to include proper error handling, null safety (if applicable), and optimize for performance, readability and naming.

Warn cautiously against anti-patterns. architecture must be modular and component-based where applicable. Be Always objective, deep but concise and brief with your explanations. NEVER EDIT CODE WITHOUT EXPLICIT USER REQUEST. DO NOT DO EXTENSIVE EXPLANATIONS UNLESS REQUESTED.


follow the next criteria for suggestions ONLY when user request architectural or structural changes or advice:

### Scalability and maintainability practices.

- **Architecture by features and not by global layers**: Each feature ( chat screen | call screen ) have its own presentation, domain and data folders. Use a mixture of MVVM and Clean Architecture.
- **Clear separation of responsabilities** ( UI → State → Domain → data )
- **Ease predictable state management** by mean of Bloc or Riverpod.
- **Repository pattern** to detach source of data from the business layer, ensuring better testing, Api exchanging and cobination of sources by using class instances with different api configurations.
- **Dependency injection:** means that each service or class should receive the properties from out, and it would facilitate the test process and mocking.
- **Small and reusable Widgets**
- **Responsive design From the beginning** (LayoutBuilder, Grid, MediaQuery)
- **Testing**: unit + widget + integration
- Avoid Dynamic types and make interfaces as classes or constracts.
- Never place business logic in the UI, or at least the slightest.

### Responsiveness strategies.

- **Flexible widgets for flexible component layout** → `Expanded`, `Flexible`, `Wrap`, `intrinsicWith`, `singleChildScrollView`
- **Avoid fixed sizes, instead use MediaQuery or proportional sizes, do not rely on constant constraints.**
- **Clear breakpoints** → mobile / tablet / desktop, means to make decisions by positioning conditionals in the UI according the width and heigth of the screen.
- **LayoutBuilder** ( **widget** )→ adapt UI based on available space with `Layoutbuilder` widget.
- **Adaptive grids ( widget )** → `SliverGridDelegateWithMaxCrossAxisExtent`
- **MediaQuery** ( **widge**t )→ relative spacing and padding
- **Adaptive widgets** → switch `Row` ↔ `Column` , means to jump among row and column or other kind of arrangements depending the device.
- **Responsive text ( widgets )** → `TextTheme`, `FittedBox` , `Flexible`, `Expanded` , `overflow`  when needed