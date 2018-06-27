# Preferences

## Atom

* Fonts
  - Good
    + Anonymous Pro
    + CamingoCode
    + Code New Roman
    + Inconsolata (use 1.3 line spacing)
    + PT Mono
    + SK Modernist (love it, but has silly ligatures, like 'fi')
  - Maybe
    + BPMono
    + Go Mono*
    + Gohufont 11 (really cool)
    + Office Code Pro Light
* UI: Isotope
* Syntax: Oceanic Next

#### Backup and Restore Atom configuration
You need only the `.json`, `.cson`, `.coffee` and `.less` files in the `~/.atom` folder, and a list of packages you had installed:

run from command line on old install
```shell
apm list --installed --bare > packages.list
```
then you do from the command line on your new install
```shell
apm install `cat packages.list`
```
(notice the backticks in that last command, not regular quotes)

This should work on Linux/Mac OSX, don’t know about windows though

For the install, you can also just use:
```shell
apm install --packages-file packages.list
```
which should work on all supported Atom platforms.

* packages.list content as of 4/26/2018:
  - fonts@3.0.3
  - isotope-ui@2.8.5
  - oceanic-next@1.0.0

---

## VSCode

* Theme: Adapta Nokto

#### User Settings
```
{
  // Tab and character settings
  "editor.detectIndentation": false,
  "editor.tabSize": 2,

  // Colors, Themes, Fonts, etc.
  "workbench.colorTheme": "Adapta Nokto",
  "editor.fontFamily": "'Anonymous Pro', Menlo, Monaco, 'Courier New', monospace, 'Apple Color Emoji'",
  "editor.fontSize": 12,
  "editor.fontWeight": "normal",
  "editor.lineNumbers": "relative",
  "workbench.editor.showTabs": true,
  "editor.wordWrap": "wordWrapColumn",

  // keybinding related settings
  "editor.multiCursorModifier": "ctrlCmd",
                            
  "editor.acceptSuggestionOnEnter": "off"
}
```
