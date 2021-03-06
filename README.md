# Rench

[![Gem Version](https://badge.fury.io/rb/rench.png)](http://badge.fury.io/rb/rench)
[![Code Climate](https://codeclimate.com/github/mrmicahcooper/rench.png)](https://codeclimate.com/github/mrmicahcooper/rench)
[![Build Status](https://travis-ci.org/mrmicahcooper/rench.png?branch=master)](https://travis-ci.org/mrmicahcooper/rench)
[![Dependency Status](https://gemnasium.com/mrmicahcooper/rench.png)](https://gemnasium.com/mrmicahcooper/rench)

Do you ever have a list of files you pull from one project to another?
Here is a cooler way to do that:

Put them in your 'toolbox' repo, maintain them, share them, and most
importantly, retrieve them easily.

- Make a Github repository called toolbox.
- Make a `toolbox/tools` directory
- Fill it with all the files you have ever used on more than one
  project.
- Make a .markdown file for all your tools so you, and anyone
  else, know how to use them.
- When you're working on a project, grab your tools and place them wherever
  needed with Rench.

## Instructions

```bash
$ gem install rench

$ rench <github_username> <filename> [new_file_location]
# Rench will only look in the `/tools` directory for <filename>

$ rench mrmicahcooper active_model_spec_helper.rb

#=> Where do you wanna put "active_model_spec_helper"?

(blank)        #=> saves as: active_model_spec_helper.rb
spec_helper.rb #=> saves as: spec_helper.rb
spec/          #=> saves as: spec/active_model_spec_helper.rb
spec           #=> saves as: spec/active_model_spec_helper.rb
```

#### Alternatively
You can just enter a Github user and it will print their tools for you
to choose one.

```bash
$ rench mrmicahcooper

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

### Dependencies

- You're gonna need __[curl][]__ to get this baby turnin'.

[curl]: http://en.wikipedia.org/wiki/CURL
