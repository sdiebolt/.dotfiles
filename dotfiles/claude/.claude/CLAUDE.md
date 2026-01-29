# Python Project Guidelines

## Project Management

- **Always use `uv`** to manage Python projects, install dependencies, build packages, etc.
- **Use `just`** and create justfiles to make building docs and running tests easier.
- **Use absolute imports** throughout the project.

## Code Quality

### Linting
- Lint using `ruff`, either through `uvx ruff` or through pre-commits.

### Type Checking
- Type check using `ty`, e.g., through `uvx ty` or through pre-commits.

### Pre-commit Hooks
- Use `prek` for managing pre-commits.

### Testing
- Use `pytest` for tests.

## Comments

- Comments should not duplicate code.
- Good comments do not excuse unclear code.
- If you can't write a clear comment, there may be a problem with the code.
- Comments should dispel confusion, not cause it.
- Explain unidiomatic code in comments.
- Provide links to the original source of copied code.
- Include links to external references where they will be most helpful.
- Add comments when fixing bugs.
- Use `TODO:` prefix for comments to mark incomplete implementations.
- All comments should end with a period.

## Naming Conventions

- Functions/methods: `snake_case`
- Classes: `PascalCase`
- Constants: `UPPER_CASE`
- Private functions/methods: leading underscore `_function_name`
- Variables: descriptive `snake_case` names

## Error Handling

- Use specific exceptions: `ValueError`, `TypeError`, `FileNotFoundError`
- Use `warnings.warn()` for non-critical issues
- Validate inputs early with descriptive error messages
- Use try/except blocks for external operations

## Documentation

- Use NumPy docstring format for all public functions
- Include Parameters, Returns, Raises sections
- Document complex algorithms with references
- Use type hints in docstrings when helpful
- Include default values in the type parameter as `arg : type, default: value`, or `arg
  : type, optional` when the default is `None`.

## Code Structure

- Use `pathlib.Path` for file operations
- Use context managers for file handling
- Prefer functional programming where appropriate
- Use list/dict comprehensions for simple transformations
- Keep functions focused on single responsibilities
