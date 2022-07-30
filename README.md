Backup
======

Backup files for if I move computers.

# Export Gnome Terminal Profile

List profiles

```
dconf dump /org/gnome/terminal/legacy/profiles:/
```

Determine the terminal profile string for the profile you will need. This is the terminal profile that I will export:

```
[/]
default='74302df5-606c-4210-95f6-f98eafad0316'
list=['b1dcc9dd-5262-4d8d-a863-c897e6d979b9', '74302df5-606c-4210-95f6-f98eafad0316']

[:74302df5-606c-4210-95f6-f98eafad0316]
background-color='rgb(25,25,25)'
background-transparency-percent=14
bold-is-bright=false
default-size-columns=94
default-size-rows=24
font='DejaVu Sans Mono 12'
foreground-color='rgb(255,255,255)'
palette=['rgb(0,0,0)', 'rgb(203,92,56)', 'rgb(143,157,106)', 'rgb(249,238,152)', 'rgb(114,134,166)', 'rgb(155,133,157)', 'rgb(6,152,154)', 'rgb(228,228,228)', 'rgb(37,37,38)', 'rgb(186,97,71)', 'rgb(142,157,106)', 'rgb(248,234,143)', 'rgb(100,133,166)', 'rgb(155,133,157)', 'rgb(52,226,226)', 'rgb(238,238,236)']
use-theme-transparency=false
use-transparent-background=true
visible-name='Twilight'

[:b1dcc9dd-5262-4d8d-a863-c897e6d979b9]
background-transparency-percent=49
bold-is-bright=false
default-size-columns=94
default-size-rows=24
use-theme-transparency=false
use-transparent-background=true
```

And the string that I will need to use to export is

```
:74302df5-606c-4210-95f6-f98eafad0316
```

The command to export that profile is (note the ending slash)

```
dconf dump /org/gnome/terminal/legacy/profiles:/:74302df5-606c-4210-95f6-f98eafad0316/ > Twilight.dconf
```

To restore the profile

```
dconf load /org/gnome/terminal/legacy/profiles:/:74302df5-606c-4210-95f6-f98eafad0316/ < Twilight.dconf
```
