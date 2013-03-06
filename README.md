# Rench

Everyone with more than one project has a list of tools they use
over and over. Rench allows you to put all those tools in a toolbox and
easily grab them for any project project.

The idea is:

- Make a Github repository called toolbox.
- Make a `toolbox/files` directory
- Fill it with all the files you use have ever used on more than one
  project.
- Make a .markdown file for all these tools so you, and anyone
  else, know how to use the tools them.
- When you're working on a project, grab your tools with Wrench:

## Instructions

```bash
$ gem install rench

$ rench <github_username> <file_name> [new_file_location]
# Rench will only look in the `/files` directory for <file_name>

$ rench mrmicahcooper active_model_spec_helper.rb

#=> Where do you wanna put the file?

$(blank) #=> saves as:  active_model_spec_helepr.rb
or
$ spec_helper.rb #=> saves as: spec_helper.rb
or
$ spec/ #=> saves as: spec/active_model_spec_helepr.rb
or
$ spec #=> saves as: spec/active_model_spec_helepr.rb
or
$ spec_helper.rb #=> saves as: spec_helper.rb
```
