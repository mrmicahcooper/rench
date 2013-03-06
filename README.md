# Rench

Do you ever have a list of files you pull from one project to another?
Here is a cooler way to do that: 

Put them in your 'toolbox' repo, maintain them, share them, and most importantly- retrieve them easily.

- Make a Github repository called toolbox.
- Make a `toolbox/files` directory
- Fill it with all the files you use have ever used on more than one
  project.
- Make a .markdown file for all these tools so you, and anyone
  else, can always know how to use your tools.
- When you're working on a project, grab your tools and stick them where
  you need with Rench.

## Instructions

```bash
$ gem install rench

$ rench <github_username> <filename> [new_file_location]
# Rench will only look in the `/files` directory for <filename>

$ rench mrmicahcooper active_model_spec_helper.rb

Where do you wanna put the "active_model_spec_helepr"?

(blank) #=> saves as:  active_model_spec_helepr.rb
or
spec_helper.rb #=> saves as: spec_helper.rb
or
spec/ #=> saves as: spec/active_model_spec_helepr.rb
or
spec #=> saves as: spec/active_model_spec_helepr.rb
```

#### Alternatively
You can just enter a Github user and it will print their toosl for you
to choose one.

```bash

$rench mrmicahcooper

Choose a file:
[0] active_record_spec_helper.rb
[1] formbuilder.rb
[2] html5.js
[3] mixins.sass
[4] step_definitions.rb
[5] support_paths.rb
[6] ui_controller.rb

$ 6

Where do you wanna put "ui_controller.rb"?

...
```

This is great for exploring other people's toolboxes.
