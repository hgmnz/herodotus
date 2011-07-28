Herodotus
---------

Herodotus, an ancient greek historian and story teller will
help you keep a changelog updated.

Oftentimes you don't think about the changelog when you make changes to your
project. Then, when it's time to cut a release, you've really lost momentum
of how those changes affect your users. You thought about these things days or
weeks ago, when you committed them to the repo.

Herodotus can help by going over your git history since a particular release
and extracting your notes. Obviously, not every commit will contain useful or
changelog worthy information, so we'll use the commit message format to
communicate what should go in the changelog. Here are the rules:

* Tag every release, so that it is easy to tell Herodotus how far back to start
  looking for changes.
* To start writing notes for use in the changelog, use the following format on 
  your git commit message:


```
Real commit message subject

Some more info on the commit

Changelog:
Anything below this line will go on the changelog. Tell your users how to
upgrade the app, what has been depracated, what will break, etc.
```

It doesn't need to be exact either. Herodotus will simply extract these 
comments, format them by adding the author and date, and either append them to 
your CHANGES file, or print them out to standard out. Once it's there you can 
tweak it at will before pushing. But the important pieces have been thought out 
at the time when you wrote the software changes - and was written right on the 
commit message, and so maintaining the changelog could be easier.

## Installation

Add herodotus to your Gemfile and run bundle.

If you're not using bundler, install via `gem install herodotus`

Then add `require 'herodotus/tasks'` to your `Rakefile`. This will provide the rake tasks with which you interface with herodotus.

## Usage

Herodotus provides a couple of rake tasks: 

```
rake -T
rake herodotus:append[since_ref]  # Appends changes to your changelog
rake herodotus:print[since_ref]   # Prints out the change log from git
```

You can optionally pass the reference (usually a tag) from which herodotus will start to look for changelog messages in your commits.
Note that some shells require you to wrap the rake task in double quotes when passing arguments. For example: `rake "herodotus:print[v1]"`
