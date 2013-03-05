## Wrench

Everyone with more than one project has a list of tools they use
over and over. Wrench allows you to put all those tools in a toolbox and
easily grab them for any project project.

The idea is:

- Make a Github repository called toolbox.
- Make a `toolbox/files` directory
- Fill it with all the files you use have ever used on more than one
  project.
- Make a .markdown file for all these tools so you, and anyone
  else, knows how to use the tools them.
- When you're working on a project, grab your tools with Wrench:

```bash
$ wrench <github_username> <file_name> [new_file_location]
# wrenc will only look in the `/files` directory for <file_name>

#example:

$ wrench mrmicahcooper active_model_spec_helper.rb

#=> Where do you want to put active_model_spec_helper.rb?

$ spec/

#=> added: spec/active_model_spec_helepr.rb
```

## Installation

    $ gem install wrench
