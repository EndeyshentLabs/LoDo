# LoDo

LoDo is keyboard based graphical Todo app made with LOVE2D and Lua.

## Using

Screen layout:

```
+----------------+---------------+
|                '               |
|  TODOs         '  DONEs        |
|                '               |
|                '               |
|                '               |
|                '               |
|                '               |
+----------------+---------------+
| T  STATUSBAR                   |
+--------------------------------+
```

`T` - current mode indicator

Modes:

- `N` - normal mode
- `I` - input mode

### Keybinds

| Key                | Action |
| ------------------ | --------------- |
| <kbd>I</kbd>       | Add new TODO |
| <kbd>D</kbd>       | Delete the highlighted TODO |
| <kbd>SPACE</kbd>   | Change the state of the TODO |
| <kbd>UP</kbd>      | Move cursor 1 element up |
| <kbd>DOWN</kbd>    | Move cursor 1 element down |

### Saving and Loading

LoDo will load todo list when you open it and will save current todo list state when you quit out of it.

## Build-it

This project is using [Fluid build system](https://github.com/EndeyshentLabs/Fluid)

```console
$ git clone https://github.com/EndeyshentLabs/lodo.git
$ cd lodo
$ ./fluid
```
