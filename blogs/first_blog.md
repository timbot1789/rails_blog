# Basic Blogpost Rendering

This is primarily a test post for rendering posts of my blog in markdown for my personal website. In order to do this, I'll need to render the markdown of this document into HTML. How am I going to do this? Well, easily enough, there's a ruby gem, [redcarpet](https://github.com/vmg/redcarpet) that can do it for me. My website is written in rails, so ruby is kinda the goto.

My current structure is this:

1. Write a blogpost manually
2. Upload it manually into the SQLite database using the rails console
3. Write the template to dynamically convert the post from markdown to HTML upon request.

Is this efficient? No! Absolutely not. It would be far more efficient to have a backend blogpost submission system that rendered the markdown into HTML, then stored the HTML in the database. For that, though, I'd need a submission system with a few other pieces:

1. Some kind of secure POST endpoint (or just direct database access)
2. A job queue that will run the article rendering as a job, and then upload that into the database
3. An ERB template that renders the blog as just plain html, no excess stuff.

The job queue is probably overkill, but I also want to add onto that an AI of some kind that can produce a quick summary of my blog post to use in the header. That would certainly require a proper rendering engine.

Overall, though, I want this to be a simple space where I can post some simple things. I don't want a big project up front. Instead I just want something I can grow over time.